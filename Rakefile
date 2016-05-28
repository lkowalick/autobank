require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*spec.rb']
  t.verbose = true
end

task default: :test
