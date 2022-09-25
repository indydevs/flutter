# frozen_string_literal: true

describe Flutter::Parser do
  def parse_fixture(name)
    File.join(__dir__, "fixtures/#{name}")
  end
  it "raises no error when a file is missing" do
    assert_empty(Flutter::Parser.new("/var/tmp/not-real.rb").signatures)
  end

  it "generates signatures for class and instance methods" do
    p = Flutter::Parser.new(parse_fixture("simple.rb"))
    assert_empty(["Simple::A::fu", "Simple::A:bar", "Simple::A::baz"] - p.signatures.keys)
  end
end
