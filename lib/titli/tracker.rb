# frozen_string_literal: true

require "set"
require_relative "persistence"
require "pry"

module Titli
  class Tracker
    def initialize(
      sources = [], storage_class = Persistence::SimpleStorage,
      storage_options = { "path": "./.titli" }
    )
      @sources = sources.map { |s| File.absolute_path(s) }
      @storage = storage_class.new(**storage_options)
      @mapping = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = Set.new } }
      @mapping.update(@storage.state) if @storage.state
    end

    def start(test)
      @current_tracepoint = TracePoint.new(:call) do |tp|
        hit!(test, tp)
      end
      @current_tracepoint&.enable
    end

    def stop
      @current_tracepoint&.disable
    end

    # TODO: this should not be dumb....
    def skip?(test)
      @mapping.key?(test)
    end

    def persist!
      @storage.persist!(@mapping)
    end

    def to_s
      @storage.to_s
    end

    attr_reader :mapping

    private

    def hit!(test, tracepoint)
      if tracked?(tracepoint.path, tracepoint.callee_id)
        @mapping[test][tracepoint.path] << (
          tracepoint.defined_class ? "#{tracepoint.defined_class}:#{tracepoint.callee_id}" : tracepoint.callee_id
        )
      end
    end

    def tracked?(file, _method)
      @sources.any?(->(source) { file.start_with?(source) })
    end
  end
end
