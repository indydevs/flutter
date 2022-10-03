# frozen_string_literal: true

require "deep_merge"
require "set"
require_relative "persistence"
require_relative "parser"
require "pry"

module Flutter
  # @attr [Hash<String, Hash<String, Set<String>>>] test_mapping Mapping of tests to
  #  files -> callable_ids
  # @attr [Hash<String, Hash<String, String>>] source_mapping Mapping of
  #  source files -> callable_id -> signature
  # @attr [Persistence::AbstractStorage] storage the storage instance used for
  #  persisting the state of the tracker
  class Tracker
    attr_reader :test_mapping, :source_mapping, :storage

    # @param [Array<String>] sources
    # @param [Array<String>] exclusions
    # @param [Class<Flutter::Persistence::AbstractStorage>] storage_class
    # @param [Hash] storage_options Additionally options that should be passed
    #  to the +storage_class+ constructor
    def initialize(sources, exclusions, storage_class, storage_options)
      @sources = sources.map { |s| File.absolute_path(s) }
      @exclusions = exclusions.map { |s| File.absolute_path(s) }
      @storage = storage_class.new(**storage_options)
      @test_mapping = @storage.test_mapping
      @previous_test_mapping = {}
      @test_source_mapping = {}
      @source_mapping = @storage.source_mapping
      @current_source_mapping = {}
      @path_mapping = {}
      @method_prefixes = {}
      @tracked_files = {}
    end

    # Starts tracking calls made by +test+
    # @param [String] test A unique identifier for the test
    def start(test)
      # Delete test from the in-memory mapping to allow each new test run
      # to store all the functions that the test calls into
      @previous_test_mapping[test] = @test_mapping.delete(test)
      @current_tracepoint = TracePoint.new(:call) do |tp|
        hit!(test, tp)
      end
      @current_tracepoint&.enable
    end

    # End tracking (should be called after a call to {#start})
    # @param [String] test A unique identifier for the test
    # @param [TrueClass, FalseClass] success Whether the test succeeded
    def stop(test, success)
      @current_tracepoint&.disable
      @test_mapping[test].merge!(@previous_test_mapping.delete(test) || {}) { |_, old, new| old + new } unless success
    end

    ##
    # Decides if a test should be skipped based on *all* of the following
    # criteria being met:
    #
    # 1. Test was seen before
    # 2. Test sources have not changed since the last time it was executed
    # 3. All the callables triggered within the scope of this test have no
    #    changes in their source since the last time this test was executed
    #
    # @param [String] test A unique identifier for the test
    # @param [String] test_location The absolute path to the source file containing the test
    # @param [String] test_source The source code of the test itself
    # @return [TrueClass, FalseClass] If the test should be skipped
    def skip?(test, test_location, test_source)
      test_location_rel = relative_path(test_location)
      @test_source_mapping.fetch(test_location_rel) do
        @test_source_mapping[test_location_rel] = {}
      end[test] = Digest::SHA1.hexdigest(test_source)
      return false unless
        @test_mapping.key?(test) && @test_source_mapping[test_location_rel][test] == @source_mapping.dig(
          test_location_rel, test
        )

      sources = @test_mapping[test]
      sources.map do |file, methods|
        @current_source_mapping[file] ||= Flutter::Parser.new(file).signatures
        methods.map do |method|
          @source_mapping.dig(file, method) == @current_source_mapping.dig(file, method)
        end.all?
      end.all?
    end

    ##
    # Persist the state of the tracker to the storage
    # specified by {#storage}
    # @return [void]
    def persist!
      @storage.update_test_mapping!(@test_mapping)
      @storage.update_source_mapping!(generate_source_mapping)
      @storage.persist!
    end

    ##
    # Reset the state of the tracker and the storage
    # that it was configured with
    # @return [void]
    def reset!
      $stdout.puts "Resetting flutter: #{@storage}"
      @storage.clear!
      @source_mapping.clear
      @test_mapping.clear
    end

    def to_s
      @storage.to_s
    end

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
        if tracepoint_class.superclass.name && tracepoint_class.to_s.include?(tracepoint_class.superclass.name)
          "#{tracepoint_class.superclass.name}::"
        else
          tracepoint_class.to_s.sub(/#<Class:(.*?)(\(.*?\))?>/, '\1::')
        end
      else
        "#{tracepoint_class.name}:"
      end
    end

    ##
    # Check if a file pair should be tracked or not based on the
    # +sources+ and +exclusions+ lists provided when initializing
    # the instance
    #
    # @param [String] file
    # @param [Symbol] _method
    def tracked?(file, _method)
      @tracked_files.fetch(file) do
        @sources.any?(->(source) { File.fnmatch?(source, file) }) && !@exclusions.any?(->(exclusion) {
          File.fnmatch?(exclusion, file)
        })
      end
    end

    ##
    # Generates a mapping of
    #
    # @return [Hash<String, Hash<String, Hash<String, String>>>]
    def generate_source_mapping
      @test_mapping.map { |_k, v| v.keys }.flatten.uniq.map do |file|
        [file, @current_source_mapping.fetch(file) { Flutter::Parser.new(file).signatures }]
      end.to_h.deep_merge(@test_source_mapping)
    end
  end
end
