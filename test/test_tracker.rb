# frozen_string_literal: true

require_relative "./test_helper"
require "flutter/tracker"
require "flutter/persistence"

class TestTracker < Minitest::Test
  def temp_dir
    Dir.mktmpdir
  end

  def fu; end
  def bar; end

  def tracker(dir)
    Flutter::Tracker.new(
      ["./lib/*", "./test/*"], [], Flutter::Persistence::Yaml, {
        path: dir,
      }
    )
  end

  def test_fresh_storage
    dir = temp_dir
    t = tracker(dir)
    t.start("fubar")
    t.stop("fubar", true)
    assert(t.persist!)
    fake_file = Tempfile.new
    refute(t.skip?("fubar", fake_file.path, "def test;end"))
    assert_includes(t.test_mapping["fubar"].keys, "lib/flutter/tracker.rb")
  end

  def test_skip_test_no_change
    dir = temp_dir
    t = tracker(dir)
    t.start("fubar")
    t.stop("fubar", true)
    fake_file = Tempfile.new
    refute(t.skip?("fubar", fake_file.path, "def test;end"))
    t.persist!
    t = tracker(dir)
    assert(t.skip?("fubar", fake_file.path, "def test;end"))
  end

  def test_failed_test_merges_tracking
    dir = temp_dir
    t = tracker(dir)
    t.start("fubar")
    fu
    t.stop("fubar", true)
    t.start("fubar")
    bar
    t.stop("fubar", false)
    assert_equal(
      t.test_mapping["fubar"]["test/test_tracker.rb"],
      Set.new(["TestTracker:fu", "TestTracker:bar"]),
    )
    t.start("fubar")
    bar
    t.stop("fubar", true)
    assert_equal(
      t.test_mapping["fubar"]["test/test_tracker.rb"],
      Set.new(["TestTracker:bar"]),
    )
  end
end
