# frozen_string_literal: true

require_relative "lib/flutter/version"

Gem::Specification.new do |spec|
  spec.name = "flutter"
  spec.version = Flutter::VERSION
  spec.authors = ["Ali-Akber Saifee", "Ankita Gupta"]
  spec.email = ["ali@indydevs.org", "ankita@indydevs.org"]

  spec.summary = "Intelligent test selection based on incremental code changes"
  spec.description = 'Flutter plugs in to your RSpec or Minitest test suites
  and helps you run only the tests that exercise the code you have changed since the last run
  '
  spec.homepage = "https://github.com/indydevs/flutter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/indydevs/flutter"
  spec.metadata["changelog_uri"] = "https://github.com/indydevs/flutter/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    %x(git ls-files -z).split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency("deep_merge", " ~> 1.2")
  spec.add_dependency("dry-configurable", "~> 0.15")
  spec.add_dependency("parser", "~> 3.1")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
