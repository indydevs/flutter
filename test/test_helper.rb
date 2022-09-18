# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "simplecov"
if ENV["CI"]
  require "simplecov-cobertura"
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
else
  require "simplecov-console"
  SimpleCov.formatter = SimpleCov::Formatter::Console
end

SimpleCov.start { track_files "lib/**/*.rb" }

require "titli"
require "minitest"

Minitest.load_plugins
require "minitest/autorun"
