# frozen_string_literal: true

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

require "rspec"
require "titli/rspec"

Titli::RSpec.configure do |config|
  config.sources << "lib"
  config.reset_storage = true
  config.enabled = true
end
