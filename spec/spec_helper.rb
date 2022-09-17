# frozen_string_literal: true

require "rspec"
require "titli/rspec"
require "simplecov"

if ENV["CI"]
  require "simplecov-cobertura"
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
else
  require "simplecov-console"
  SimpleCov.formatter = SimpleCov::Formatter::Console
end

SimpleCov.start do
  coverage_dir "rspec_coverage"
  enable_coverage :branch
  track_files "lib/**/*.rb"
end

Titli::RSpec.configure do |config|
  config.sources << "lib"
end
