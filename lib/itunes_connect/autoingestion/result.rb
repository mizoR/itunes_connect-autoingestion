module ItunesConnect
  module Autoingestion
    class Result
      def initialize(row_data)
        parse(row_data)
      end

      private

      def parse(row_data)
        # FIXME: Awesome parsing process
        @row_data = row_data
      end

      def to_s
        @row_data.to_s
      end
    end
  end
end
