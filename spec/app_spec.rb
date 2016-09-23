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
  end
end
