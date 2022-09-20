# frozen_string_literal: true

require_relative "titli/version"
require_relative "titli/config"
require_relative "titli/rspec"

module Titli
  class Error < StandardError; end
  include Titli::Config
end
