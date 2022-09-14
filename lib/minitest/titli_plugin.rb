# frozen_string_literal: true

require "titli/tracker"

module Minitest
  class << self
    attr_reader :titli_tracker

    def plugin_titli_options(opts, _options)
      opts.on("--titli", "Watch for changes and rerun relevant tests") do
        @titli_enabled = true
      end
    end

    def plugin_titli_init(options)
      if @titli_enabled
        require "minitest/titli"
        @titli_tracker = ::Titli::Tracker.new(["./lib"])
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
