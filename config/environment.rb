require "sinatra/base"
require "json"

class WatchdogApp < Sinatra::Base
  configure :development do
  end

  configure :production do
  end

  configure do
    $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")
    Dir.glob("#{File.dirname(__FILE__)}/../lib/*.rb") { |lib| require File.basename(lib, '.*') }

    GitHub.token = ENV["GITHUB_TOKEN"]

    patterns_file = File.join(File.dirname(__FILE__), "patterns.txt")
    patterns_config = File.readlines(patterns_file).each { |line| line.chomp! }
    pattern_strings = patterns_config.select { |line| !line.start_with?("#") && !line.empty? }
    pattern_regexps = pattern_strings.map! { |str| str.to_regexp || str }
    set :patterns, pattern_regexps

    enable :logging
  end
end
