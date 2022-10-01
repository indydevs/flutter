# frozen_string_literal: true

require "rake/testtask"
require "keepachangelog"

Rake::TestTask.new(:unit) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

Rake::TestTask.new(:integration) do |t|
  t.test_files = FileList["integration_tests/minitest/grape_app/test/**/*_test.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task test: [:unit, :spec]
task default: [:test, :spec, "rubocop:autocorrect_all"]

desc "Increment the version, update changelog and create a tag for the release"
task :release, [:version] do |_t, args|
  parser = Keepachangelog::MarkdownParser.load("CHANGELOG.md")
  log = parser.parsed_content["versions"].delete("Unreleased")
  sh("gem bump --pretend #{args[:version]}") do |ok, _|
    if ok
      new_version = %x(gem bump --no-commit #{args[:version]} | awk '{print $4}' | uniq).chomp
      parser.parsed_content["versions"]["Unreleased"] = { "url" => nil, "date" => nil, "changes" => {} }
      parser.parsed_content["versions"][new_version] = log
      File.open("CHANGELOG.md", "w") do |file|
        file.write(parser.to_md)
      end
      %x(git add CHANGELOG.md lib/flutter/version.rb)
      %x(git commit -m "Bump flutter to #{new_version}")
      %x(gem tag -s)
      Rake::Task["release_notes"].execute({ version: new_version })
    end
  end
end

desc "Get release notes for the current or specific version"
task :release_notes, [:version] do |_t, args|
  version = (args[:version] || Flutter::VERSION)
  parser = Keepachangelog::MarkdownParser.load("CHANGELOG.md")
  parser.parsed_content.delete("intro")
  parser.parsed_content.delete("title")
  parser.parsed_content["versions"] = parser.parsed_content["versions"].select { |k, _v| k == version }
  lines = parser.to_md.split("\n")
  chunk = lines.slice_after { |line| line.include?("## #{version}") }.to_a[1] || []
  puts chunk.join("\n")
end
