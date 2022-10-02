# frozen_string_literal: true

require "not_exist"

module Test
  module Parser
    class LoadError
      def impossible; end
    end
  end
end
