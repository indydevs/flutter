# frozen_string_literal: true

require "deep_merge"
require "set"
require_relative "persistence"
require_relative "parser"
require "pry"

module Flutter
  class Tracker
    attr_reader :test_mapping, :source_mapping

    def initialize(sources, storage_class, storage_options)
      @sources = sources.map { |s| File.absolute_path(s) }
      @storage = storage_class.new(**storage_options)
      @test_mapping = @storage.test_mapping
      @test_source_mapping = {}
      @source_mapping = @storage.source_mapping
      @current_source_mapping = {}
      @path_mapping = {}
      @method_prefixes = {}
    end

    # Resets the in-memory test_mapping for each test, and stores the methods that
    # the test calls in the in-memory test_mapping
    def start(test)
      # Delete test from the in-memory mapping to allow each new test run
      # to store all the functions that the test calls into
      @test_mapping.delete(test)
      @current_tracepoint = TracePoint.new(:call) do |tp|
        hit!(test, tp)
      end
      @current_tracepoint&.enable
    end

    def stop
      @current_tracepoint&.disable
    end

    def skip?(test, test_location, test_source)
      test_location_rel = relative_path(test_location)
      @test_source_mapping.fetch(test_location_rel) do
        @test_source_mapping[test_location_rel] = {}
      end[test] = Digest::SHA1.hexdigest(test_source)
      return false unless
        @test_mapping.key?(test) && @test_source_mapping[test_location_rel][test] == @source_mapping.dig(
          test_location_rel, test,
        )

      sources = @test_mapping[test]
      sources.map do |file, methods|
        @current_source_mapping[file] ||= Flutter::Parser.new(file).signatures
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

      if tracked?(tracepoint.path, tracepoint.callee_id)
        rel_path = relative_path(tracepoint.path)
        prefix = method_prefix(tracepoint.defined_class)
        @test_mapping.fetch(test) do
          @test_mapping[test] = {}
        end.fetch(rel_path) { @test_mapping[test][rel_path] = Set.new } << (
          prefix ? "#{prefix}#{tracepoint.callee_id}" : tracepoint.callee_id
        )
      end
    end

    def relative_path(file)
      @path_mapping[file] ||= Pathname.new(file).relative_path_from(Dir.pwd).to_s
    end

    ##
    # Returns a prefix based on Tracepoint.defined_class
    #
    # @param [Class] tracepoint_class
    # @return [String]
    #
    def method_prefix(tracepoint_class)
      return unless tracepoint_class

      @method_prefixes[tracepoint_class] ||= if tracepoint_class.to_s.start_with?("#<Class")
        tracepoint_class.to_s.sub(/#<Class:(.*?)(\(.*?\))?>/, '\1::')
      else
        "#{tracepoint_class.name}:"
      end
    end

    def tracked?(file, _method)
      @sources.any?(->(source) { file.start_with?(source) })
    end

    def generate_source_mapping
      @test_mapping.map { |_k, v| v.keys }.flatten.uniq.map do |file|
        [file, @current_source_mapping.fetch(file) { Flutter::Parser.new(file).signatures }]
      end.to_h.deep_merge(@test_source_mapping)
    end
  end
end
