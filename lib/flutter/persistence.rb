# frozen_string_literal: true

require "fileutils"
require "set"
module Flutter
  module Persistence
    class AbstractStorage
      def initialize
        load!
      end

      # :nocov:
      def test_mapping
        raise NotImplementedError
      end

      def source_mapping
        raise NotImplementedError
      end

      def update_test_mapping!(mapping)
        raise NotImplementedError
      end

      def update_source_mapping!(mapping)
        raise NotImplementedError
      end

      def persist!(updates)
        raise NotImplementedError
      end

      def to_s
        raise NotImplementedError
      end

      def clear!
        raise NotImplementedError
      end

      def load!
        raise NotImplementedError
      end
      # :nocov:
    end

    class Yaml < AbstractStorage
      require "yaml"
      # ruby >= 3.1 requires this
      YAML_LOAD_OPTS = RUBY_VERSION > "3.1" ? { permitted_classes: [Hash, Set, Symbol] } : {}
      def initialize(path:)
        @path = File.absolute_path(path)
        @full_path = File.join(@path, "state.yml")
        @state = { test_mapping: {}, source_mapping: {} }
        super()
      end

      def load!
        if File.exist?(@full_path)
          persisted = YAML.load(File.read(@full_path), **YAML_LOAD_OPTS)
          @state.update(persisted) if persisted
        end
      end

      def test_mapping
        @state.fetch(:test_mapping) { @state[:test_mapping] = {} }
      end

      def source_mapping
        @state.fetch(:source_mapping) { @state[:source_mapping] = {} }
      end

      def update_test_mapping!(mapping)
        test_mapping.merge!(mapping)
      end

      def update_source_mapping!(mapping)
        source_mapping.merge!(mapping)
      end

      def clear!
        FileUtils.rm(@full_path) if File.exist?(@full_path)
        @state.clear
      end

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
      def initialize(path:)
        @path = File.absolute_path(path)
        FileUtils.mkdir_p(@path) unless File.exist?(@path)
        @full_path = File.join(@path, "state.pstore")
        @state = nil
        super()
      end

      def load!
        @state = PStore.new(@full_path)
        @state.transaction do
          @state[:test_mapping] ||= {}
          @state[:source_mapping] ||= {}
        end
      end

      def test_mapping
        @state.transaction do
          return @state[:test_mapping]
        end
      end

      def source_mapping
        @state.transaction do
          return @state[:source_mapping]
        end
      end

      def update_test_mapping!(mapping)
        @state.transaction do
          @state[:test_mapping] ||= {}
          @state[:test_mapping].merge!(mapping)
        end
      end

      def update_source_mapping!(mapping)
        @state.transaction do
          @state[:source_mapping] ||= {}
          @state[:source_mapping].merge!(mapping)
        end
      end

      def clear!
        FileUtils.rm(@full_path) if File.exist?(@full_path)
      end

      def persist!
      end

      def to_s
        "state: #{@full_path}"
      end
    end
  end
end
