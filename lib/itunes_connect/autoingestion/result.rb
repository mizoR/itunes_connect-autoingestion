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

      def respond_to?(method_name)
        method_name = method_name.to_s
        @data.include?(method_name) || super
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
