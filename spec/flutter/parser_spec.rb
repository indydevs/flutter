# frozen_string_literal: true

require "spec_helper"
describe Flutter::Parser do
  it "raises no error when file doesnt exist" do
    parser = described_class.new("/var/tmp/no-exist.rb")
    expect(parser.signatures).to(be_empty)
  end
end
