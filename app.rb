require_relative "config/environment"

class WatchdogApp < Sinatra::Base
  post "/push" do
    logger.info "Received push webhook"

    # Check for valid JSON
    begin
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      logger.warn "Invalid JSON payload"
      status 400
      return
    end

    # Check for valid data
    begin
      head_commit_id = payload.fetch("head_commit").fetch("id")
      repo = payload.fetch("repository").fetch("full_name")
    rescue KeyError
      logger.warn "Invalid webhook payload"
      status 422
      return
    end

    logger.info "Analyzing commit #{head_commit_id} on repository #{repo}"
    github = GitHub.new(settings.github_token)
    commit = github.get_commit(repo, head_commit_id)
    analyzer = Analyzer.new(commit)
    patterns = settings.patterns
    logger.info "Patterns: #{patterns.count}"
    matches = analyzer.match(patterns)
    unless matches.empty?
      logger.info "Matches found: #{matches.count}"
      github.make_private(repo)
    end
    return
  end
end
