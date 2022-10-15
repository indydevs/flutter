# frozen_string_literal: true

require "method_source"
require_relative "tracker"

module Flutter
  module RSpec
    class << self
      attr_accessor :filtered, :total

      def tracker
        @tracker ||= Flutter::Tracker.new(
          Flutter.config.sources, Flutter.config.exclusions,
          Flutter.config.storage_class, Flutter.config.storage_options
        )
      end
    end

    module ClassMethods
      def filtered_examples
        return super unless Flutter.enabled

        Flutter::RSpec.filtered ||= Set.new
        Flutter::RSpec.total ||= Set.new
        Flutter::RSpec.tracker.reset! if Flutter.enabled && Flutter.config.reset_storage

        original = super
        Flutter::RSpec.total.merge(original)
        return original unless Flutter.enabled

        original.select do |example|
          !(example.metadata[:block] && Flutter::RSpec.tracker.skip?(
            example.full_description,
            example.metadata[:absolute_file_path],
            example.metadata[:block].source,
          ).tap { |skip| Flutter::RSpec.filtered << example if skip })
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
      Flutter::RSpec.tracker.stop(example.full_description,
        example.execution_result.exception.nil?) if Flutter.enabled
    end

    config.after(:suite) do
      if Flutter.enabled
        $stdout.puts
        $stdout.puts "Flutter filtered #{Flutter::RSpec.filtered.length} / #{Flutter::RSpec.total.length} examples"
        Flutter::RSpec.tracker.persist!
      end
    end
  end
end
