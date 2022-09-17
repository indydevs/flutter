# frozen_string_literal: true

require "rspec"
require_relative "tracker"
require "pry"

module Titli
  module RSpec
    class Config
      attr_accessor :enabled, :sources, :storage_options, :storage_class, :reset_storage

      def initialize
        @enabled = true
        @sources = ["app"]
        @storage_options = { path: "./.titli" }
        @storage_class = Titli::Persistence::SimpleStorage
        @reset_storage = false
      end
    end
    class << self
      attr_accessor :filtered, :tracker

      def enabled?
        @enabled
      end

      def configure
        config = Config.new
        yield config

        @enabled = config.enabled
        if @enabled
          ::RSpec.configure do |config|
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

          @filtered = 0
          @tracker = Titli::Tracker.new(config.sources, config.storage_class, config.storage_options)
          @tracker.reset! if config.reset_storage
        end
      end
    end

    module ClassMethods
      def filtered_examples
        original = super
        return original unless Titli::RSpec.enabled?

        original.select do |example|
          skip = Titli::RSpec.tracker.skip?(example.full_description)
          Titli::RSpec.filtered += 1 if skip
          !skip
        end
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
