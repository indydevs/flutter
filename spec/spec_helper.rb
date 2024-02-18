# typed: false
# frozen_string_literal: true

if ENV["CI"] || ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter %r{^/spec/}
    if ENV["CI"]
      require "simplecov-cobertura"
      SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
    else
      require "simplecov-console"
      SimpleCov.formatter = SimpleCov::Formatter::Console
    end

    coverage_dir "rspec_coverage"
    track_files "lib/**/*.rb"
  end
end

require "rspec"
require "flutter"

Flutter.configure do |config|
  config.sources << Dir.pwd
  config.storage_options = { path: "./.flutter/rspec" }
  config.reset_storage = ENV["RESET_STATE"] == "true"
  config.enabled = true
end
