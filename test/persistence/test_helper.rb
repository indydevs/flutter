# frozen_string_literal: true

require_relative "../test_helper"

module StorageTest
  def temp_dir
    @path ||= Dir.mktmpdir
  end

  def create_storage
    raise NotImplementedError
  end

  def storage_name
    raise NotImplementedError
  end

  def test_create_storage
    storage = create_storage
    storage.persist!
    assert_path_exists(File.join(temp_dir, storage_name))
  end

  def test_reload_storage
    storage = create_storage
    storage.update_source_mapping!({ "fu" => { "bar" => "quz" } })
    storage.update_test_mapping!({ "quz" => { "bar" => "fu" } })
    storage.persist!
    storage = create_storage
    assert_equal({ "bar" => "quz" }, storage.source_mapping["fu"])
    assert_equal({ "bar" => "fu" }, storage.test_mapping["quz"])
  end
end
