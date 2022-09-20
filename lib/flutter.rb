# frozen_string_literal: true

require_relative "flutter/version"
require_relative "flutter/config"
require_relative "flutter/rspec"

module Flutter
  class Error < StandardError; end
  include Flutter::Config
end
