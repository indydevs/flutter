# frozen_string_literal: true

require "spec_helper"
require "titli/rspec"
describe Titli::RSpec do
  it "is enabled" do
    expect(Titli::RSpec).to(be_enabled)
  end
end
