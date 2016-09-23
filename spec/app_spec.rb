require_relative "spec_helper"

describe WatchdogApp do
  describe "POST /push" do
    it "gracefully responds to a malformed request" do
      post "/push", ""
      last_response.status.must_equal 400
    end

    it "gracefully responds to a well-formed JSON request that does not contain the proper data" do
      post "/push", '{ "foo": "bar", "boolean": true, "array": [1, 2, 3] }'
      last_response.status.must_equal 422
    end

    it "responds to a valid request" do
      fixture = read_fixture("github_webhook_push_normal.json")
      post "/push", fixture
      last_response.status.must_equal 200
    end
  end
end
