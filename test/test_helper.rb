# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
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
    track_files "lib/**/*.rb"
  end
end
require "flutter"
require "minitest"

Minitest.load_plugins
require "minitest/autorun"
