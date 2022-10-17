# typed: true
# frozen_string_literal: true

require_relative "test_helper"
require "flutter/persistence"
class TestYamlStorage < Minitest::Test
  include StorageTest
  def create_storage
    Flutter::Persistence::Yaml.new(path: temp_dir)
  end

  def storage_name
    "state.yml"
  end
end
