# typed: false
# frozen_string_literal: true

require "flutter"
require "flutter/tracker"
require "flutter/minitest"

module Minitest
  class << self
    def plugin_flutter_init(options)
      if Flutter.enabled
        Flutter::Minitest.flutter_tracker.reset! if Flutter.config.reset_storage
        reporter << Flutter::Minitest::Reporter.new(options)
      end
    end
  end
end
