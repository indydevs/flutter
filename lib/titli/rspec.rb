# frozen_string_literal: true

require "rspec"
require_relative "tracker"
require "pry"

module Titli
  module RSpec
    class << self
      attr_accessor :filtered

      def tracker
        @tracker ||= Titli::Tracker.new(
          Titli.config.sources, Titli.config.storage_class, Titli.config.storage_options,
        )
      end
    end

    module ClassMethods
      def filtered_examples
        Titli::RSpec.filtered ||= 0
        Titli::RSpec.tracker.reset! if Titli.enabled && Titli.config.reset_storage

        original = super
        return original unless Titli.enabled

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

if defined?(RSpec.configure)
  RSpec.configure do |config|
    config.around(:each) do |example|
      Titli::RSpec.tracker.start(example.full_description) if Titli.enabled
      example.run
      Titli::RSpec.tracker.stop if Titli.enabled
    end

    config.after(:suite) do
      if Titli.enabled
        $stdout.puts
        $stdout.puts "Titli filtered out #{Titli::RSpec.filtered} examples"
        Titli::RSpec.tracker.persist!
      end
    end
  end
end
