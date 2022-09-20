# frozen_string_literal: true

require "dry/configurable"
require_relative "persistence"

module Titli
  module Config
    class << self
      private

      def included(other)
        other.extend(Dry::Configurable)
        other.class_eval do
          setting(:enabled, default: false, reader: true)
          setting(:sources, default: Set.new([Dir.pwd]))
          setting(:storage_class, default: Titli::Persistence::SimpleStorage)
          setting(:storage_options, default: { path: "./.titli" })
          setting(:reset_storage, default: false)
        end
      end
    end
  end
end
