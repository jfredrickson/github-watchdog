require_relative "spec_helper"

describe WatchdogApp do
  it "responds to POST /push" do
    post "/push"
    last_response.status.must_equal 200
  end
end
