require "itunes_connect/autoingestion/version"
require "itunes_connect/autoingestion/ingester"
require "itunes_connect/autoingestion/command"
require "itunes_connect/autoingestion/result"
require "itunes_connect/autoingestion/data"

module ItunesConnect
  module Autoingestion
    class Error < StandardError
    end
  end
end
