# frozen_string_literal: true

require "titli/tracker"

module Minitest
  class << self
    attr_reader :titli_tracker

    def plugin_titli_options(opts, _options)
      opts.on("--titli", "Only run tests affected by files changed since last run") do
        @titli_enabled = true
      end
      opts.on("--titli-reset", "Reset titli persisted state before running tests") do
        @titli_reinit = true
      end
    end

    def plugin_titli_init(options)
      if @titli_enabled
        require "minitest/titli"
        @titli_tracker = ::Titli::Tracker.new(["./lib"])
        @titli_tracker.reset! if @titli_reinit
        reporter << Minitest::TitliReporter.new(@titli_tracker, options)
      end
    end
  end

  class TitliReporter < AbstractReporter
    def initialize(tracker, options)
      super()
      @tracker = tracker
      @verbose = options[:verbose]
    end

    def report
      @tracker.persist!
      if @verbose
        puts "Persisted titli #{@tracker}"
      end
    end
  end
end
