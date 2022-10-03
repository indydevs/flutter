# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "rake", "~> 13.0"

group :development do
  gem "yard", "~> 0.9.28"
  gem "redcarpet", "~> 3.5"
end

group :test, :development do
  gem "pry", "~> 0.14.1"
  gem "overcommit", "~> 0.59.1"
  gem "gem-release", "~> 2.2"
  gem "guard", "~> 2.18"
  gem "keepachangelog", "~> 0.6.1"
  gem "rubocop", "~> 1.21"
  gem "rubocop-shopify", require: false
  gem "rubocop-minitest", "~> 0.22.1"
  gem "rubocop-rspec", "~> 2.13"
  gem "rubocop-rake", "~> 0.6.0"
  # For integration test app
  gem "dotenv"
  gem "grape"
  gem "grape-entity"
  gem "grape-swagger"
  gem "rack-test", require: "rack/test"
end

group :test do
  gem "guard-minitest", "~> 2.4"
  gem "guard-rspec", "~> 4.7"
  gem "minitest", "~> 5.0"
  gem "rspec", "~> 3.11"
  gem "simplecov", "~> 0.21.2", require: false
  gem "simplecov-console", "~> 0.9.1"
  gem "simplecov-cobertura", "~> 2.1"
end
