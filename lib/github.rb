require "octokit"

class GitHub
  def initialize
    @client = Octokit::Client.new(token: @token)
  end

  def self.token=(token)
    @token = token
  end

  def self.token
    @token
  end

  def get_commit(repo, commit_id)
    @client.commit(repo, commit_id)
  end
end
