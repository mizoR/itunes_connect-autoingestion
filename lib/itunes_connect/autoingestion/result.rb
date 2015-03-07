require 'csv'

module ItunesConnect
  module Autoingestion
    class Result
      def initialize(raw_data)
        @raw_data = raw_data
        @rows = parse(raw_data)
      end

      def each
        @rows.each do |data|
          yield data
        end
      end

      def to_s
        @raw_data
      end

      private

      def parse(raw_data)
        ::CSV.new(raw_data, col_sep: "\t", headers: true).map {|row| Data.new(row)}
      end
    end
  end
end
