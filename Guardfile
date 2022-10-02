# frozen_string_literal: true

guard :minitest, test_folders: ["test"] do
  watch(%r{^(test|lib)/(.*/)?([^/]+)\.rb$}) { "test" }
end

guard :rspec, cmd: "rspec", all_on_start: true do
  watch(%r{^(spec|lib)/(.*/)?([^/]+)\.rb$}) { "spec" }
end
