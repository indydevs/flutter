# frozen_string_literal: true

require "dry/configurable"
require_relative "persistence"

module Flutter
  module Config
    class << self
      private

      def included(other)
        other.extend(Dry::Configurable)
        other.class_eval do
          setting(:enabled, default: false, reader: true)
          setting(:sources, default: Set.new(["#{Dir.pwd}/*"]))
          setting(:exclusions, default: Set.new(["./vendor/*"]))
          setting(:storage_class, default: Flutter::Persistence::Marshal)
          setting(:storage_options, default: { path: "./.flutter" })
          setting(:reset_storage, default: false)
        end
      end
    end
  end
end
