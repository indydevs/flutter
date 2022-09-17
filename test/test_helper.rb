# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "titli"
require "minitest"
require "simplecov"

if ENV["CI"]
  require "simplecov-cobertura"
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
else
  require "simplecov-console"
  SimpleCov.formatter = SimpleCov::Formatter::Console
end

SimpleCov.start

Minitest.load_plugins
require "minitest/autorun"
