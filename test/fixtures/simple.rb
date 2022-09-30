# frozen_string_literal: true

module Simple
  class B
    def self.ffu # rubocop:disable Style/ClassMethodsDefinitions
      1
    end

    def bbar
      2
    end
  end

  class A < B
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
