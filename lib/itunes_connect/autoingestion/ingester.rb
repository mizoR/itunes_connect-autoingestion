require "itunes_connect/autoingestion/command"

module ItunesConnect
  module Autoingestion
    class Ingester
      attr_reader :username, :password, :vendor_id, :report_type, :report_subtype, :date_type, :date

      def initialize(username: , password: , vendor_id: , report_type: 'Sales', report_subtype: 'Summary', date_type: 'Daily', date: Date.today)
        @username = username
        @password = password
        @vendor_id = vendor_id
        @report_type = report_type
        @date_type =  date_type
        @report_subtype = report_subtype
        @date = date
      end

      def ingest
        Command.new(self).run
      end
    end
  end
end
