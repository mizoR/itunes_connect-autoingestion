require "itunes_connect/autoingestion"

module ItunesConnect
  module Autoingestion
    class Cli
      def initialize(argv)
        if argv.size != 3
          $stderr.puts "wrong arguments (argv: #{argv})"
          exit 1
        end

        @params = {
          username:  argv[0],
          password:  argv[1],
          vendor_id: argv[2],
        }
      end

      def run
        Ingester.new(@params).ingest
      end
    end
  end
end
