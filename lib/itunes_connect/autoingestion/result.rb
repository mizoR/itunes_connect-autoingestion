require 'csv'

module ItunesConnect
  module Autoingestion
    class Data
      def initialize(row)
        @data = row.headers.inject({}) do |hash, header|
          method_name = header.downcase.gsub(' ', '_')
          hash[method_name] = row[header]
          hash
        end
      end

      def method_missing(method_name)
        method_name = method_name.to_s
        if @data.include?(method_name)
          @data[method_name]
        else
          super
        end
      end
    end

    class Result
      def initialize(row_data)
        @rows = parse(row_data)
      end

      def each
        @rows.each do |data|
          yield data
        end
      end

      private

      def parse(row_data)
        ::CSV.new(row_data, col_sep: "\t", headers: true).map {|row| Data.new(row)}
      end
    end
  end
end
