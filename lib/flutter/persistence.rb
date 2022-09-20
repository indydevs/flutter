# frozen_string_literal: true

require "fileutils"
require "set"
require "yaml"
module Flutter
  module Persistence
    class AbstractStorage
      attr_reader :state

      def initialize
        load!
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
    end

    class SimpleStorage < AbstractStorage
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

      def update_test_mapping!(mapping)
        @state.fetch(:test_mapping) { @state[:test_mapping] = {} }.merge!(mapping)
      end

      def update_source_mapping!(mapping)
        @state.fetch(:source_mapping) { @state[:source_mapping] = {} }.merge!(mapping)
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
  end
end
