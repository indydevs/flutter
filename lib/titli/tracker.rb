# frozen_string_literal: true

require "set"
require_relative "persistence"
require_relative "parser"
require "pry"

module Titli
  class Tracker
    attr_reader :test_mapping, :source_mapping

    def initialize(
      sources = [], storage_class = Persistence::SimpleStorage,
      storage_options = { "path": "./.titli" }
    )
      @sources = sources.map { |s| File.absolute_path(s) }
      @storage = storage_class.new(**storage_options)
      @test_mapping = @storage.state.fetch(:test_mapping, {})
      @source_mapping = @storage.state.fetch(:source_mapping, {})
      @current_source_mapping = {}
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
      return false unless @test_mapping.key?(test)

      sources = @test_mapping[test]
      sources.map do |file, methods|
        @current_source_mapping[file] ||= Titli::Parser.new(file).signatures
        methods.map do |method|
          @source_mapping.dig(file, method) == @current_source_mapping.dig(file, method)
        end.all?
      end.all?
    end

    def persist!
      @storage.update_test_mapping!(@test_mapping)
      @storage.update_source_mapping!(generate_source_mapping)
      @storage.persist!
    end

    def reset!
      @storage.clear!
      @source_mapping.clear
      @test_mapping.clear
    end

    def to_s
      @storage.to_s
    end

    attr_reader :mapping

    private

    def hit!(test, tracepoint)
      return unless File.exist?(tracepoint.path)

      rel_path = Pathname.new(tracepoint.path).relative_path_from(Dir.pwd).to_s
      if tracked?(tracepoint.path, tracepoint.callee_id)
        parent = tracepoint.defined_class
        prefix = nil
        if parent
          prefix = if tracepoint.defined_class.to_s.start_with?("#<Class")
            tracepoint.defined_class.to_s.sub(/#<Class:(.*?)>/, '\1::')
          else
            "#{tracepoint.defined_class}:"
          end
        end
        @test_mapping.fetch(test) do
          @test_mapping[test] = {}
        end.fetch(rel_path) { @test_mapping[test][rel_path] = Set.new } << (
          prefix ? "#{prefix}#{tracepoint.callee_id}" : tracepoint.callee_id
        )
      end
    end

    def tracked?(file, _method)
      @sources.any?(->(source) { file.start_with?(source) })
    end

    def generate_source_mapping
      @test_mapping.map { |_k, v| v.keys }.flatten.uniq.map do |file|
        [file, @current_source_mapping[file] || Titli::Parser.new(file).signatures]
      end.to_h
    end
  end
end
