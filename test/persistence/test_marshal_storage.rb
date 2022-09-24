# frozen_string_literal: true

require_relative "test_helper"
require "flutter/persistence"
class TestMarshalStorage < Minitest::Test
  include StorageTest
  def create_storage
    Flutter::Persistence::Marshal.new(path: temp_dir)
  end

  def storage_name
    "state.pstore"
  end
end
