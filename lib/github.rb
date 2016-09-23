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

  def get_files(repo, commit_id)
    commit = @client.commit(repo, commit_id)
    commit[:files]
  end
end
