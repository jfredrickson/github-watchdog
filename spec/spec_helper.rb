ENV["RACK_ENV"] = "test"

require "bundler"
Bundler.require :default, :test
require "minitest/autorun"
require "rack/test"
require_relative "../app"

include Rack::Test::Methods

def app
  WatchdogApp
end

def read_fixture(fixture)
  File.read(File.join(File.dirname(__FILE__), "fixtures", fixture))
end
