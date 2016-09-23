require_relative "config/environment"

class WatchdogApp < Sinatra::Base
  post "/push" do
    # Check for valid JSON
    begin
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      status 400
      return
    end

    # Check for valid data
    begin
      head_commit_id = payload.fetch("head_commit").fetch("id")
    rescue KeyError
      status 422
      return
    end
  end
end
