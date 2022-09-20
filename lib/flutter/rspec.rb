# frozen_string_literal: true

require "rspec"
require_relative "tracker"
require "pry"

module Flutter
  module RSpec
    class << self
      attr_accessor :filtered

      def tracker
        @tracker ||= Flutter::Tracker.new(
          Flutter.config.sources, Flutter.config.storage_class, Flutter.config.storage_options,
        )
      end
    end

    module ClassMethods
      def filtered_examples
        Flutter::RSpec.filtered ||= 0
        Flutter::RSpec.tracker.reset! if Flutter.enabled && Flutter.config.reset_storage

        original = super
        return original unless Flutter.enabled

        original.select do |example|
          skip = Flutter::RSpec.tracker.skip?(example.full_description)
          Flutter::RSpec.filtered += 1 if skip
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
        prepend Flutter::RSpec::ClassMethods
      end
    end
  end
end

if defined?(RSpec.configure)
  RSpec.configure do |config|
    config.around(:each) do |example|
      Flutter::RSpec.tracker.start(example.full_description) if Flutter.enabled
      example.run
      Flutter::RSpec.tracker.stop if Flutter.enabled
    end

    config.after(:suite) do
      if Flutter.enabled
        $stdout.puts
        $stdout.puts "Flutter filtered out #{Flutter::RSpec.filtered} examples"
        Flutter::RSpec.tracker.persist!
      end
    end
  end
end
