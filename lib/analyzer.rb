# Analyzes the content of a GitHub commit
class Analyzer
  attr_accessor :commit

  # Initialize with a GitHub commit hash (built from a GitHub API JSON response)
  def initialize(commit)
    @commit = commit
  end

  # Takes an array of patterns (string or regex) and returns an array of matches.
  def match(patterns)
    files = @commit.fetch(:files)
    regex = Regexp.union(patterns)
    matches = []
    files.each do |file|
      if patch = file[:patch]
        patch.match(regex) do |match|
          matches << {
            match: match,
            file: file
          }
        end
      end
    end
    matches
  end
end
