# frozen_string_literal: true

require "test_helper"
require "titli/tracker"
require "titli/persistence"

class TestTracker < Minitest::Test
  def temp_dir
    Dir.mktmpdir
  end

  def test_fresh_storage
    dir = temp_dir
    tracker = Titli::Tracker.new(
      ["./lib"], Titli::Persistence::SimpleStorage, {
        path: dir,
      },
    )
    tracker.start("fubar")
    tracker.stop
    assert(tracker.persist!)
    assert_includes(tracker.test_mapping["fubar"].keys, "lib/titli/tracker.rb")
  end
end
