# typed: true
# frozen_string_literal: true

module FlutterFixture
  module Parser
    class Bar
      def impossible; end
    end

    class Fu < Bar
      def impossible; end
    end
  end
end
