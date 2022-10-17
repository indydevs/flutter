# typed: false
# frozen_string_literal: true

describe Flutter::Parser do
  def parse_fixture(name)
    File.join(__dir__, "fixtures/#{name}")
  end
  it "raises no error when a file is missing" do
    assert_empty(Flutter::Parser.new("/var/tmp/not-real.rb").signatures)
  end

  it "raises no error when a file can't be parsed" do
    refute_includes Flutter::Parser.new(parse_fixture("parser/name_error.rb")).signatures,
      "FlutterFixture::Parser::Fu:impossible"
    refute_includes Flutter::Parser.new(parse_fixture("parser/load_error.rb")).signatures,
      "FlutterFixture::Parser::LoadError:impossible"
  end

  it "generates signatures for class and instance methods" do
    p = Flutter::Parser.new(parse_fixture("simple.rb"))
    assert_empty(["Simple::A::fu", "Simple::A:bar", "Simple::A::baz"] - p.signatures.keys)
  end

  it "generates signatures for inherited methods" do
    p = Flutter::Parser.new(parse_fixture("simple.rb"))
    assert_empty(["Simple::A::ffu", "Simple::A:bbar"] - p.signatures.keys)
  end
end
