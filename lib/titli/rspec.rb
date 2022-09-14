# frozen_string_literal: true

require "rspec"
require_relative "tracker"
require "pry"

# TODO: this should be explicitly enabled by something like Titli.enable { |titli| .... }

module RSpec
  class << self
    def tracker
      @tracker ||= Titli::Tracker.new(["app"])
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do |example|
    example.metadata[:titli_effect] = false
    ::RSpec.tracker.start(example.full_description)
  end
  config.after(:each) do |_example|
    ::RSpec.tracker.stop
  end
  config.after(:all) do
    ::RSpec.tracker.persist!
  end
end

module Titli
  module RSpec
    module ClassMethods
      def filtered_examples
        super.select do |example|
          !::RSpec.tracker.skip?(example.full_description)
        end
      end
    end
  end
end

module RSpec
  module Core
    class ExampleGroup
      class << self
        prepend Titli::RSpec::ClassMethods
      end
    end
  end
end
