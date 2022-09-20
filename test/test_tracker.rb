# frozen_string_literal: true

require "test_helper"
require "flutter/tracker"
require "flutter/persistence"

class TestTracker < Minitest::Test
  def temp_dir
    Dir.mktmpdir
  end

  def test_fresh_storage
    dir = temp_dir
    tracker = Flutter::Tracker.new(
      ["./lib"], Flutter::Persistence::SimpleStorage, {
        path: dir,
      },
    )
    tracker.start("fubar")
    tracker.stop
    assert(tracker.persist!)
    assert(tracker.skip?("fubar"))
    assert_includes(tracker.test_mapping["fubar"].keys, "lib/flutter/tracker.rb")
  end
end
