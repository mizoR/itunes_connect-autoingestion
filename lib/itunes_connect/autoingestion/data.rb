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
  end
end
