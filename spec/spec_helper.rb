# frozen_string_literal: true

if ENV["CI"] || ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
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
require "titli"

Titli.configure do |config|
  config.sources << Dir.pwd
  config.storage_options = { path: "./.titli/rspec" }
  config.reset_storage = ENV["CI"]
  config.enabled = true
end
