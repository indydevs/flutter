# typed: false
# frozen_string_literal: true

require "dry/configurable"
require "dry/configurable/version"
require_relative "persistence"

module Flutter
  module Config
    class << self
      private

      def included(other)
        other.extend(Dry::Configurable)
        other.class_eval do
          # dry-configurable versions < 0.13 expect default values
          # as the second parameter, whereas newer versions have started
          # deprecating passing the default value as a non keyword argument.
          if Dry::Configurable::VERSION >= "0.13"
            setting(:enabled, default: false, reader: true)
            setting(:sources, default: Set.new(["#{Dir.pwd}/*"]))
            setting(:exclusions, default: Set.new(["./vendor/*"]))
            setting(:storage_class, default: Flutter::Persistence::Marshal)
            setting(:storage_options, default: { path: "./.flutter" })
            setting(:reset_storage, default: false)
          else
            # :nocov:
            setting(:enabled, false, reader: true)
            setting(:sources, Set.new(["#{Dir.pwd}/*"]))
            setting(:exclusions, Set.new(["./vendor/*"]))
            setting(:storage_class, Flutter::Persistence::Marshal)
            setting(:storage_options, { path: "./.flutter" })
            setting(:reset_storage, false)
            # :nocov:
          end
        end
      end
    end
  end
end
