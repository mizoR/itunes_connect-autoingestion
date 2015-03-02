require "itunes_connect/autoingestion/result"
require "shellwords"
require "zlib"
require "forwardable"
require "tempfile"

module ItunesConnect
  module Autoingestion
    class Error < StandardError
    end

    class FileNotFound < Error
    end

    class ExitError < Error
    end

    class Command
      class Builder
        extend Forwardable

        attr_reader :command
        def_delegator :command, :ingester

        def initialize(command)
          @command = command
        end

        def build
          property_path = Tempfile.open(['itunes_connect-autoingestion', '.properties']) {|file|
            file.puts "userID = #{ingester.username}"
            file.puts "password = #{ingester.password}"

            # HACK: 相対パスにしなければ、javaコマンドの実行が "Property file missing" でエラーになる
            Pathname(file.path).relative_path_from(Pathname(Dir::pwd)).to_s
          }

          cmds = [
            java,
            '-cp',
            Dir::tmpdir,
            '-classpath',
            classpath,
            classfilename,
            property_path,
            ingester.vendor_id,
            ingester.report_type,
            ingester.date_type,
            ingester.report_subtype,
            ingester.date.strftime("%Y%m%d"),
          ]

          command = cmds.map(&:to_s).map(&:shellescape).join(' ')

          yield command
        ensure
          File.delete(property_path) rescue nil
        end

        private

        def classpath
          File.expand_path File.join(__dir__, '../../../java/Autoingestion/')
        end

        def classfilename
          'Autoingestion'
        end

        def java
          java_home = ENV['JAVA_HOME']
          java_home ? File.join(java_home, 'bin', 'java') : 'java'
        end
      end

      attr_reader :ingester

      def initialize(ingester)
        @ingester = ingester
      end

      def run
        Builder.new(self).build do |command|
          out = `#{command}`

          raise ExitError.new(out) if $?.exitstatus != 0

          # NOTE: javaコマンドのエラーになってもステータスコードは 0が返ってしまっている
          gz_file, _ = out.split
          raise FileNotFound.new(out) if !File.exist?(gz_file)

          Zlib::GzipReader.open(gz_file) {|gz|
            Result.new gz.read
          }
        end
      end
    end
  end
end
