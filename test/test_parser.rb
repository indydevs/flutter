# frozen_string_literal: true

describe Flutter::Parser do
  it "raises no error when a file is missing" do
    assert_empty(Flutter::Parser.new("/var/tmp/not-real.rb").signatures)
  end
end
