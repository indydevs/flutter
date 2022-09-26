# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

Rake::TestTask.new(:integration) do |t|
  t.test_files = FileList["test/test_app_skee/test/**/*_test.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new do |t|
  t.options << "-A"
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task default: [:test, :spec, :rubocop]
