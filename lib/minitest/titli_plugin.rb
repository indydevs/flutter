# frozen_string_literal: true

require "titli"
require "titli/tracker"

module Minitest
  class << self
    attr_reader :titli_tracker

    def plugin_titli_options(opts, _options)
      opts.on("--titli", "Only run tests affected by files changed since last run") do
        ::Titli.config.enabled = true
      end
      opts.on("--titli-reset", "Reset titli persisted state before running tests") do
        ::Titli.config.reset_storage = true
      end
    end

    def plugin_titli_init(options)
      if ::Titli.enabled
        require "minitest/titli"
        @titli_tracker = ::Titli::Tracker.new(
          ::Titli.config.sources, ::Titli.config.storage_class, ::Titli.config.storage_options,
        )
        @titli_tracker.reset! if ::Titli.config.reset_storage
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
      return unless ::Titli.enabled

      @tracker.persist!
      if @verbose
        $stdout.puts "Persisted titli #{@tracker}"
      end
    end
  end
end
