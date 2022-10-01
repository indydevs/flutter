# frozen_string_literal: true

require "fileutils"
require "set"
module Flutter
  module Persistence
    # The abstract base storage.
    #
    # To implement a custom storage, override the following methods:
    # * {#test_mapping}
    # * {#source_mapping}
    # * {#update_test_mapping!}
    # * {#update_source_mapping!}
    # * {#load!}
    # * {#persist!}
    # * {#clear!}
    #
    # @abstract Override this class to implement a custom storage
    class AbstractStorage
      def initialize
        load!
      end

      # :nocov:

      # Mapping of +test_id -> source file -> callable_id+
      # @return [Hash<String, Hash<String, Set<String>>>]
      def test_mapping
        raise NotImplementedError
      end

      # Mapping of +source file -> callable_id -> signature+
      # @return [Hash<String, Hash<String, String>>] mapping
      def source_mapping
        raise NotImplementedError
      end

      ##
      # Update {#test_mapping}
      #
      # @param [Hash<String, Hash<String, String>>] mapping
      def update_test_mapping!(mapping)
        raise NotImplementedError
      end

      ##
      # Update {#source_mapping}
      #
      # @param [Hash<String, Hash<String, String>>] mapping
      def update_source_mapping!(mapping)
        raise NotImplementedError
      end

      # Save the state of test & source mapping to the underlying
      # storage
      # @return [void]
      def persist!
        raise NotImplementedError
      end

      # Clear any saved state in the underlying storage
      # @return [void]
      def clear!
        raise NotImplementedError
      end

      # If the storage was already persisted load the current state
      # @return [void]
      def load!
        raise NotImplementedError
      end
      # :nocov:
    end

    class Yaml < AbstractStorage
      require "yaml"
      # ruby >= 3.1 requires this
      YAML_LOAD_OPTS = RUBY_VERSION > "3.1" ? { permitted_classes: [Hash, Set, Symbol] } : {}

      # @param [String] path The directory to store the +state.yml+ file
      def initialize(path:)
        @path = File.absolute_path(path)
        @full_path = File.join(@path, "state.yml")
        @state = { test_mapping: {}, source_mapping: {} }
        super()
      end

      # (see AbstractStorage#load!)
      def load!
        if File.exist?(@full_path)
          persisted = YAML.load(File.read(@full_path), **YAML_LOAD_OPTS)
          @state.update(persisted) if persisted
        end
      end

      # (see AbstractStorage#test_mapping)
      def test_mapping
        @state.fetch(:test_mapping) { @state[:test_mapping] = {} }
      end

      # (see AbstractStorage#source_mapping)
      def source_mapping
        @state.fetch(:source_mapping) { @state[:source_mapping] = {} }
      end

      # (see AbstractStorage#update_test_mapping!)
      def update_test_mapping!(mapping)
        test_mapping.merge!(mapping)
      end

      # (see AbstractStorage#update_source_mapping!)
      def update_source_mapping!(mapping)
        source_mapping.merge!(mapping)
      end

      # (see AbstractStorage#clear!)
      def clear!
        FileUtils.rm(@full_path) if File.exist?(@full_path)
        @state.clear
      end

      # (see AbstractStorage#persist!)
      def persist!
        FileUtils.mkdir_p(@path) unless File.exist?(@path)
        File.open(@full_path, "w") { |file| file.write(@state.to_yaml) }
      end

      def to_s
        "state: #{@full_path}"
      end
    end

    class Marshal < AbstractStorage
      require "pstore"
      # @param [String] path The directory to store the marshaled state file +state.pstore+
      def initialize(path:)
        # Fake change
        @path = File.absolute_path(path)
        FileUtils.mkdir_p(@path) unless File.exist?(@path)
        @full_path = File.join(@path, "state.pstore")
        @state = nil
        super()
      end

      # (see AbstractStorage#load!)
      def load!
        @state = PStore.new(@full_path)
        @state.transaction do
          @state[:test_mapping] ||= {}
          @state[:source_mapping] ||= {}
        end
      end

      # (see AbstractStorage#test_mapping)
      def test_mapping
        @state.transaction do
          return @state[:test_mapping]
        end
      end

      # (see AbstractStorage#source_mapping)
      def source_mapping
        @state.transaction do
          return @state[:source_mapping]
        end
      end

      # (see AbstractStorage#update_test_mapping!)
      def update_test_mapping!(mapping)
        @state.transaction do
          @state[:test_mapping] ||= {}
          @state[:test_mapping].merge!(mapping)
        end
      end

      # (see AbstractStorage#update_source_mapping!)
      def update_source_mapping!(mapping)
        @state.transaction do
          @state[:source_mapping] ||= {}
          @state[:source_mapping].merge!(mapping)
        end
      end

      # (see AbstractStorage#clear!)
      def clear!
        FileUtils.rm(@full_path) if File.exist?(@full_path)
      end

      # (see AbstractStorage#persist!)
      def persist!
      end

      # @return [String]
      def to_s
        "state: #{@full_path}"
      end
    end
  end
end
