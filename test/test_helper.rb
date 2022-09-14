# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "titli"
require "minitest"

Minitest.load_plugins
require "minitest/autorun"