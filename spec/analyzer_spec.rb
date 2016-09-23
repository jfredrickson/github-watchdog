require_relative "spec_helper"

describe WatchdogApp do
  describe "Analyzer" do
    it "initializes with GitHub commit data" do
      github_commit = JSON.parse(read_fixture("github_commit_single_file.json"), symbolize_names: true)
      analyzer = Analyzer.new(github_commit)
      analyzer.commit[:sha].must_equal github_commit[:sha]
    end

    it "identifies a match when a string pattern matches" do
      github_commit = JSON.parse(read_fixture("github_commit_single_file.json"), symbolize_names: true)
      analyzer = Analyzer.new(github_commit)
      patterns = [ "Nobody", "foo", "bar" ]
      results = analyzer.match(patterns)
      results.count.must_equal 1
    end

    it "identifies a match when a regex pattern matches" do
      github_commit = JSON.parse(read_fixture("github_commit_single_file.json"), symbolize_names: true)
      analyzer = Analyzer.new(github_commit)
      patterns = [ /^\+Nobody/, "foo", "bar" ]
      results = analyzer.match(patterns)
      results.count.must_equal 1
    end

    it "does not match a non-matching set of patterns" do
      github_commit = JSON.parse(read_fixture("github_commit_single_file.json"), symbolize_names: true)
      analyzer = Analyzer.new(github_commit)
      patterns = [ "foo", "bar", /baz/ ]
      results = analyzer.match(patterns)
      results.count.must_equal 0
    end

    it "ignores binary files" do
      github_commit = JSON.parse(read_fixture("github_commit_binary_files.json"), symbolize_names: true)
      analyzer = Analyzer.new(github_commit)
      patterns = /.*/
      results = analyzer.match(patterns)
      results.count.must_equal 0
    end

    it "identifies multiple file matches" do
      github_commit = JSON.parse(read_fixture("github_commit_multiple_files.json"), symbolize_names: true)
      analyzer = Analyzer.new(github_commit)
      patterns = [ "repository", "margin" ]
      results = analyzer.match(patterns)
      results.count.must_equal 2
    end
  end
end
