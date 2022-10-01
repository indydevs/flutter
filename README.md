# Flutter: Intelligent test selection based on incremental code changes

[![CI](https://github.com/indydevs/flutter/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/indydevs/flutter/actions/workflows/main.yml)
[![codecov](https://codecov.io/github/indydevs/flutter/branch/main/graph/badge.svg?token=XANF37D9C1)](https://codecov.io/github/indydevs/flutter)
[![Gem](https://img.shields.io/gem/v/flutter)](https://rubygems.org/gems/flutter)

```
 __   __
(  \,/  )
 \_ | _/
 (_/ \_)

```
Flutter plugs in to your [RSpec](https://rspec.info/) or [Minitest](https://github.com/minitest/minitest) test suites and helps you run only the tests that exercise the
code you have changed since the last run.

It can be used in local development as a live incremental test runner in
combination with [Guard](https://github.com/guard/guard) (See examples for [minitest](#with-guard) and [rspec](#with-guard-1) respectively)
or in continuous integration environments to only run the subset of tests affected by a pull request or changeset
(See [CI Recipes](#configuring-flutter-in-continuous-integration)).

## How?
Flutter tracks each method call within the context of each test case in your test suite and persists this mapping along with
a signature for all the methods that were exercised. On subsequent runs Flutter intercepts test enumeration and skips any test if
all the following conditions are true:

- The test was seen before
- The source of the test has not changed
- All the methods exercised in the last recorded run have no changes in their source

## Usage

### Minitest

- Add the gem as a dependency

  ```ruby
  gem "flutter"
  ```
- Include it in your `test_helper.rb`:

  ```ruby
  require 'flutter'
  ```
- Enable & configure it in your `test_helper.rb`:

  ```ruby
  Flutter.configure do |config|
    config.enabled = true
    # Paths to consider when tracking test -> source mappings. Default: Dir.pwd/*
    config.sources = ["./app/*", "./test/*"]
    # Paths to ignore for tracking test -> source. Default: ./vendor
    config.exclusions = ["./vendor/*"]
    # Storage type. Default: Flutter::Persistence::Marshal
    config.storage_class = Flutter::Persistence::Marshal
    # Where to store the state. Default: ./.flutter
    config.storage_options = {path: "./.flutter"}
    # Whether to reset the stored state before the test run. Default: false
    config.reset_storage = false
  end
  ```

#### With guard
Add the following to your `Guardfile`:

```ruby
guard :minitest, test_folders: ["test"] do
  watch(%r{^{test,lib}/(.*/)?([^/]+)\.rb$}) { "test" }
end
```

### RSpec

- Add the gem as a dependency:

  ```ruby
  gem "flutter"
  ```
- Include the plugin in your `spec_helper.rb`:

  ```ruby
  require 'flutter'
  ```
- Enable & configure it in your `spec_helper.rb`:

  ```ruby
  Flutter.configure do |config|
    config.enabled = true
    # Paths to consider when tracking test -> source mappings. Default: Dir.pwd/*
    config.sources = ["./app/*", "./test/*"]
    # Paths to ignore for tracking test -> source. Default: ./vendor
    config.exclusions = ["./vendor/*"]
    # Storage type. Default: Flutter::Persistence::Marshal
    config.storage_class = Flutter::Persistence::Marshal
    # Where to store the state. Default: ./.flutter
    config.storage_options = {path: "./.flutter"}
    # Whether to reset the stored state before the test run. Default: false
    config.reset_storage = false
  end
  ```
#### With guard
Using the same configuration as above add the following to your `Guardfile`:

```ruby
guard :rspec, cmd: "rspec" do
  watch(%r{^{spec,lib}/(.*/)?([^/]+)\.rb$}) { "spec" }
end
```
## Configuring flutter in continuous integration
**TODO**

## Related work

Flutter is heavily inspired by [testmon](https://github.com/tarpas/pytest-testmon)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This project uses [overcommit](https://github.com/sds/overcommit) to enforce standards. Enable the precommit hooks in your local checkout by running: `overcommit --sign`

To install this gem onto your local machine, run `bundle exec rake install`.

### Releasing a new version
- Ensure that the [Unreleased](./CHANGELOG.md#Unreleased) section of the changelog is up to date
  and contains useful details.
- Create a new release using the `release` rake task as follows (for more details about specifying the version change
  run `gem bump --help` which is the command used by the task):
  - Patch release `bundle exec rake release["-v patch"]`
  - Minor release `bundle exec rake release["-v minor"]`
  - Major release `bundle exec rake release["-v major"]`
  > **Note**
  > The `release` rake task automates updating the changelog & version, committing the changes & creating a new tag
- Push the tag. The CI workflow for tag pushes will take care of publishing the gem & creating a github release.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/indydevs/flutter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/indydevs/flutter/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Flutter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/indydevs/flutter/blob/main/CODE_OF_CONDUCT.md).
