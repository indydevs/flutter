# frozen_string_literal: true

require_relative "lib/flutter/version"

Gem::Specification.new do |spec|
  spec.name = "flutter"
  spec.version = Flutter::VERSION
  spec.authors = ["Ali-Akber Saifee", "Ankita Gupta"]
  spec.email = ["ali@indydevs.org", "ankita@indydevs.org"]

  spec.summary = "Intelligent test selection based on incremental code changes"
  spec.description = 'Plug in for RSpec & Minitest test suites
  to run only the tests that exercise the code that has changed
  '
  spec.homepage = "https://flutter.indydevs.org"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/indydevs/flutter"
  spec.metadata["bug_tracker_uri"] = "#{spec.metadata["source_code_uri"]}/issues"
  spec.metadata["changelog_uri"] = "#{spec.metadata["source_code_uri"]}/blob/master/CHANGELOG.md"
  spec.metadata["ducmentation_uri"] = spec.homepage
  spec.files = Dir.chdir(__dir__) do
    %x(git ls-files -z).split("\x0").reject do |f|
      (f == __FILE__) || f.match(
        %r{\A(?:(?:bin|test|spec|integration_tests)/|\.(?:git|github))},
      )
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency("deep_merge", " ~> 1.2")
  spec.add_dependency("dry-configurable", "~> 0.11")
  spec.add_dependency("parser", "~> 3.1")
end
