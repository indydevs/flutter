# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

class TestFlutter < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil(::Flutter::VERSION)
  end
end
