# frozen_string_literal: true

require_relative "flutter/version"
require_relative "flutter/config"
require_relative "flutter/minitest"
require_relative "flutter/rspec"
require_relative "flutter/persistence"

module Flutter
  class Error < StandardError; end
  include Flutter::Config
end
