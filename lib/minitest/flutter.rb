# frozen_string_literal: true

require "minitest"

module Minitest
  module Flutter
    module ClassMethods
      def runnable_methods
        super.select { |test| !Minitest.flutter_tracker.skip?("#{name}##{test}") }
      end
    end

    def after_setup
      super
      Minitest.flutter_tracker&.start(location) if ::Flutter.enabled
    end

    def before_teardown
      Minitest.flutter_tracker&.stop if ::Flutter.enabled
      super
    end
  end
end

module Minitest
  class Test
    prepend Minitest::Flutter
    class << self
      prepend Minitest::Flutter::ClassMethods
    end
  end
end
