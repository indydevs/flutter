# frozen_string_literal: true

guard :minitest, cli: "--flutter -v", test_folders: ["test"] do
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) { "test" }
end

guard :rspec, cmd: "rspec" do
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) { "spec" }
end
