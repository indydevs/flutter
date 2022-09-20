# frozen_string_literal: true

require "spec_helper"
require "flutter/rspec"
describe Flutter::RSpec do
  it "is enabled" do
    expect(Flutter.enabled).to(be_truthy)
  end
end
