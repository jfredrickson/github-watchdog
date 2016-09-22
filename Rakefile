require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs = ["lib", "test"]
  t.name = "spec"
  # t.warning = true
  # t.verbose = true
  t.test_files = FileList["test/**/*_spec.rb"]
end

task test: :spec
task default: :spec
