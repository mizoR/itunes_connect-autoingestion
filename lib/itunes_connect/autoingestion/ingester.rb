module ItunesConnect
  module Autoingestion
    class Ingester
      attr_reader :username, :password, :vendor_id, :report_type, :report_subtype, :date_type, :date

      def initialize(username: , password: , vendor_id: , report_type: 'Sales', report_subtype: 'Summary', date_type: 'Daily', date: (Date.today - 1), strategy: nil)
        @username = username
        @password = password
        @vendor_id = vendor_id
        @report_type = report_type
        @date_type =  date_type
        @report_subtype = report_subtype
        @date = date
        @strategy = strategy
      end

      def ingest
        strategy.new(self).run
      end

      private

      def strategy
        case @strategy.to_s
        when 'java' then Command
        else
          Command   # FIXME Change to more better strategy
        end
      end
    end
  end
end
