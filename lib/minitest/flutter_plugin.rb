# frozen_string_literal: true

require "flutter"
require "flutter/tracker"

module Minitest
  class << self
    attr_reader :flutter_tracker

    def plugin_flutter_options(opts, _options)
      opts.on("--flutter", "Only run tests affected by files changed since last run") do
        ::Flutter.config.enabled = true
      end
      opts.on("--flutter-reset", "Reset flutter persisted state before running tests") do
        ::Flutter.config.reset_storage = true
      end
    end

    def plugin_flutter_init(options)
      if ::Flutter.enabled
        require "minitest/flutter"
        @flutter_tracker = ::Flutter::Tracker.new(
          ::Flutter.config.sources, ::Flutter.config.storage_class, ::Flutter.config.storage_options,
        )
        @flutter_tracker.reset! if ::Flutter.config.reset_storage
        reporter << Minitest::FlutterReporter.new(@flutter_tracker, options)
      end
    end
  end

  class FlutterReporter < AbstractReporter
    def initialize(tracker, options)
      super()
      @tracker = tracker
      @verbose = options[:verbose]
    end

    def report
      return unless ::Flutter.enabled

      @tracker.persist!
      if @verbose
        $stdout.puts "Persisted flutter #{@tracker}"
      end
    end
  end
end
