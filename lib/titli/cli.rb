# frozen_string_literal: true

require "thor"
require_relative "runner"
module Titli
  class CLI < Thor
    class << self
      def exit_on_failure?
        true
      end

      def is_thor_reserved_word?(word, type)  # rubocop:disable Naming/PredicateName
        return false if word == "run"

        super
      end
    end

    desc "run", "Run Titli"

    method_option :source,
      type: :array,
      default: ["."],
      aliases: ["-s"]
    def run(_path = ".")
      Titli::Runner.new(options[:source]).start
    end
  end
end
