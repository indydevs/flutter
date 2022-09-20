# frozen_string_literal: true

require "spec_helper"
require "titli/rspec"
describe Titli::RSpec do
  it "is enabled" do
    expect(Titli.enabled).to(be_truthy)
  end
end
