# frozen_string_literal: true

module Simple
  class A
    def self.fu # rubocop:disable Style/ClassMethodsDefinitions
      1
    end

    def bar
      2
    end

    class << self
      def baz
        3
      end
    end
  end
end
