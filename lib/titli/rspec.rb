# frozen_string_literal: true

require "rspec"
require_relative "tracker"
require "pry"

# TODO: this should be explicitly enabled by something like Titli.enable { |titli| .... }

RSpec.configure do |config|
  config.before(:each) do |example|
    Titli::RSpec.tracker.start(example.full_description) if Titli::RSpec.enabled?
  end
  config.after(:each) do |_example|
    Titli::RSpec.tracker.stop if Titli::RSpec.enabled?
  end
  config.after(:suite) do
    if Titli::RSpec.enabled?
      $stdout.puts "Titli filtered out #{Titli::RSpec.filtered} examples"
      Titli::RSpec.tracker.persist!
    end
  end
end

module Titli
  module RSpec
    class Config
      attr_accessor :enabled, :sources, :storage_options, :storage_class

      def initialize
        @enabled = true
        @sources = ["app"]
        @storage_options = { path: "./.titli" }
        @storage_class = Titli::Persistence::SimpleStorage
      end

      def reset!
        Titli::RSpec.tracker.reset!
      end
    end
    class << self
      attr_accessor :filtered, :tracker

      def enabled?
        @enabled
      end

      def configure(&block)
        config = Config.new
        yield config
        @enabled = config.enabled
        @filtered = 0
        @tracker = Titli::Tracker.new(config.sources, config.storage_class, config.storage_options)
      end
    end

    module ClassMethods
      def filtered_examples
        original = super
        return original unless Titli::RSpec.enabled?

        filtered = original.select do |example|
          !Titli::RSpec.tracker.skip?(example.full_description)
        end
        Titli::RSpec.filtered += 1
        filtered
      end
    end
  end
end

module RSpec
  module Core
    class ExampleGroup
      class << self
        prepend Titli::RSpec::ClassMethods
      end
    end
  end
end
