# frozen_string_literal: true

require "fileutils"
require "set"
require "yaml"
module Titli
  module Persistence
    class AbstractStorage
      attr_reader :state

      def initialize
        load!
      end

      def persist!(updates)
        raise NotImplementedError
      end

      def to_s
        raise NotImplementedError
      end

      def load!
        raise NotImplementedError
      end
    end

    class SimpleStorage < AbstractStorage
      def initialize(path:)
        @path = File.absolute_path(path)
        @updates_path = File.join(@path, "state.yml")
        @state = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = Set.new } }
        super()
      end

      def load!
        # @state = YAML.load(File.read(@updates_path), permitted_classes: [Hash, Set]) if File.exist?(@updates_path)
        if File.exist?(@updates_path)
          persisted = YAML.load(File.read(@updates_path))
          @state.update(persisted) if persisted
        end
      end

      def persist!(updates)
        @state.merge!(updates)
        FileUtils.mkdir_p(@path) unless File.exist?(@path)
        File.open(@updates_path, "w") { |file| file.write(@state.to_yaml) }
      end

      def to_s
        "state: #{@updates_path}"
      end
    end
  end
end
