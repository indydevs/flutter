# typed: false
# frozen_string_literal: true

require "method_source"
require_relative "tracker"

begin
  require "minitest"
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module Flutter
  module Minitest
    class << self
      attr_accessor :filtered, :total

      def flutter_tracker
        @tracker ||= Flutter::Tracker.new(
          Flutter.config.sources,
          Flutter.config.exclusions,
          Flutter.config.storage_class,
          Flutter.config.storage_options,
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
          $stdout.puts "Flutter filtered #{Flutter::Minitest.filtered} / #{Flutter::Minitest.total} tests"
          if @verbose
            $stdout.puts "Persisted flutter #{Flutter::Minitest.flutter_tracker}"
          end
        end
      end
    end

    module Hooks
      module ClassMethods
        def runnable_methods
          return super unless ::Flutter.enabled

          Flutter::Minitest.filtered ||= 0
          Flutter::Minitest.total ||= 0
          default = super()
          Flutter::Minitest.total += default.length
          default.select do |test|
            !Minitest.flutter_tracker.skip?(
              "#{name}##{test}",
              File.absolute_path(instance_method(test).source_location[0]),
              instance_method(test).source,
            ).tap { |skip| Flutter::Minitest.filtered += 1 if skip }
          end
        end
      end

      def after_setup
        super
        Minitest.flutter_tracker&.start(location) if ::Flutter.enabled
      end

      def before_teardown
        Minitest.flutter_tracker&.stop(location, failures.empty?) if ::Flutter.enabled
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
