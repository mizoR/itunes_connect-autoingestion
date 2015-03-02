require "itunes_connect/autoingestion"
require "optparse"

module ItunesConnect
  module Autoingestion
    class Cli
      def initialize(argv)
        @params = parse(argv)
      end

      def run
        Ingester.new(@params).ingest
      end

      private

      def parse(argv)
        options = {
          username:  ENV['ITUNES_CONNECT_USERNAME'],
          password:  ENV['ITUNES_CONNECT_PASSWORD'],
          vendor_id: ENV['ITUNES_CONNECT_VENDOR_ID'],
          report_type:    'Sales',
          report_subtype: 'Summary',
          date_type: 'Daily',
          date:      Date.today.strftime("%Y-%m-%d"),
        }
        OptionParser.new do |parser|
          parser.instance_eval do
            self.banner  = "Usage: #{$0} [opts]"
            separator ""
            separator "Options:"

            on("--username [$ITUNES_CONNECT_USERNAME]") {|v| options[:username] = v}
            on("--password [$ITUNES_CONNECT_PASSWORD]") {|v| options[:password] = v}
            on("--vendor_id [$ITUNES_CONNECT_VENDOR_ID]") {|v| options[:vendor_id] = v}

            %i|report_type report_subtype date_type date|.each do |key|
              on("--#{key} [#{options[key]}]") {|v| options[key] = v}
            end

            parse!
          end
        end

        cast(options)
      end

      def cast(params={})
        params[:date] = Date.parse(params[:date])

        params
      end
    end
  end
end
