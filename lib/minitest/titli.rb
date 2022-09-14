# frozen_string_literal: true

require "minitest"

module Minitest
  module Titli
    module ClassMethods
      def runnable_methods
        super.select { |test| !Minitest.titli_tracker.skip?("#{name}##{test}") }
      end
    end

    def after_setup
      super
      Minitest.titli_tracker&.start(location)
    end

    def before_teardown
      Minitest.titli_tracker&.stop
      super
    end
  end
end

module Minitest
  class Test
    prepend Minitest::Titli
    class << self
      prepend Minitest::Titli::ClassMethods
    end
  end
end
