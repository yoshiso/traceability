require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


namespace :traceability do

  desc "run test server"
  task :run_test_server do
    system "bundle exec rackup example/test_server/config.ru"
  end

  task :run_web_server do
    system "bundle exec rackup config.ru"
  end

end