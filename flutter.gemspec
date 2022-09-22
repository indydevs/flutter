# frozen_string_literal: true

require_relative "lib/flutter/version"

Gem::Specification.new do |spec|
  spec.name = "flutter"
  spec.version = Flutter::VERSION
  spec.authors = ["Ali-Akber Saifee", "Ankita Gupta"]
  spec.email = ["ali@indydevs.org", "ankita@indydevs.org"]

  spec.summary = "Selectively run specs based on changed files"
  spec.description = "Selectively run specs based on changed files"
  spec.homepage = "https://github.com/indydevs/flutter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

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

  spec.add_dependency("deep_merge")
  spec.add_dependency("dry-configurable")
  spec.add_dependency("parser")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
