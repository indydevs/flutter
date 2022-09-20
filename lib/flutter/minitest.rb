# frozen_string_literal: true

require_relative "tracker"

begin
  require "minitest"
rescue LoadError  # rubocop:disable Lint/SuppressedException
end

module Flutter
  module Minitest
    class << self
      attr_accessor :filtered

      def flutter_tracker
        @tracker ||= Flutter::Tracker.new(
          Flutter.config.sources, Flutter.config.storage_class, Flutter.config.storage_options,
        )
      end
    end

    if defined?(::Minitest::AbstractReporter)
      class Reporter < ::Minitest::AbstractReporter
        def initialize(options)
          super()
          @verbose = options[:verbose]
        end

        def report
          return unless ::Flutter.enabled

          Flutter::Minitest.flutter_tracker.persist!
          $stdout.puts "Flutter filtered out #{Flutter::Minitest.filtered} tests"
          if @verbose
            $stdout.puts "Persisted flutter #{Flutter::Minitest.flutter_tracker}"
          end
        end
      end
    end

    module Hooks
      module ClassMethods
        def runnable_methods
          Flutter::Minitest.filtered ||= 0
          super.select do |test|
            skip = Minitest.flutter_tracker.skip?("#{name}##{test}")
            if skip
              Flutter::Minitest.filtered += 1
            end
            !skip
          end
        end
      end

      def after_setup
        super
        Minitest.flutter_tracker&.start(location) if ::Flutter.enabled
      end

      def before_teardown
        Minitest.flutter_tracker&.stop if ::Flutter.enabled
        super
      end
    end
  end
end

if defined?(Minitest::Test)
  module Minitest
    class Test
      prepend Flutter::Minitest::Hooks
      class << self
        prepend Flutter::Minitest::Hooks::ClassMethods
      end
    end
  end
end
