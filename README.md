# Flutter: Intelligent test selection based on incremental code changes

[![CI](https://github.com/indydevs/flutter/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/indydevs/flutter/actions/workflows/main.yml)
[![codecov](https://codecov.io/github/indydevs/flutter/branch/main/graph/badge.svg?token=XANF37D9C1)](https://codecov.io/github/indydevs/flutter)
[![Gem](https://img.shields.io/gem/v/flutter)](https://rubygems.org/gems/flutter)
[![Docs](http://img.shields.io/badge/yard-docs-blue.svg)](https://flutter.indydevs.org)

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
**ALL** the following conditions are true:

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
- Enable & configure it in your `test_helper.rb` (See [Configuration options](#configuration-options) for available options):

  ```ruby
  Flutter.configure do |config|
    config.enabled = true
  end
  ```
- Run your test suite the way you normally would (for example: `bundle exec rake test`). The first run will run all
  tests. After the test run has completed the mapping of test cases to exercised code will be persisted in the `./.flutter`
  folder.
- Now make changes and run the test suite again. Only the relevant tests will be executed.

#### With guard
Using the same configuration as above (and assuming that the application
sources are in the `./lib` folder while the tests are in the `./test` folder)
add the following to your `Guardfile`:

```ruby
guard :minitest, test_folders: ["test"] do
  watch(%r{^(test|lib)/(.*/)?([^/]+)\.rb$}) { "test" }
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
- Enable & configure it in your `spec_helper.rb` (See [Configuration options](#configuration-options) for available options):

  ```ruby
  Flutter.configure do |config|
    config.enabled = true
  end
  ```
- Run your specs the way you normally would (for example: `bundle exec rspec`). The first run will run all
  tests. After the test run has completed the mapping of test cases to exercised code will be persisted in the `./.flutter`
  folder.
- Now make changes and run rspec again. Only the relevant examples will be executed.

#### With guard
Using the same configuration as above (and assuming that the application
sources are in the `./app` & `./lib` folders while the specs are in the `./spec` folder)
add the following to your `Guardfile`:

```ruby
guard :rspec, cmd: "rspec" do
  watch(%r{^(spec|app|lib)/(.*/)?([^/]+)\.rb$}) { "spec" }
end
```

### Configuration options
|      option       | Description                                                    |                  Type                   |             Default             |
|:-----------------:|:---------------------------------------------------------------|:---------------------------------------:|:-------------------------------:|
|     `enabled`     | Whether flutter is enabled                                     |         `TrueClass, FalseClass`         |             `true`              |
|     `sources`     | List of glob style expressions to select source files to track |                  `Set`                  |       `["#{Dir.pwd}/*"]`        |
|   `exclusions`    | List of glob style expressions to exclude sources files        |                  `Set`                  |   `["#{Dir.pwd}/vendor}/*"]`    |
|  `storage_class`  | The storage class to use for persisting the state              | `Flutter::Persistence::AbstractStorage` | `Flutter::Persistence::Marshal` |
| `storage_options` | Additional options to pass to the storage class                |                 `Hash`                  |     `{path: './.flutter'}`      |
|  `reset_storage`  | Whether to clear the persisted state on initialization         |         `TrueClass, FalseClass`         |             `false`             |





## Configuring flutter in continuous integration

Flutter can be used in continuous integration environments to speed up the turn
around time from running tests by only running tests affected by the changes
in a pull request.

### Github Actions
The following example workflow with github actions does the following:
- Always run all tests on the `main` branch
- Only run tests affected by the "current" commit for CI workflows triggered by a `push` event on other branches
- If the CI workflow is triggered due to a `pull_request` event, run all tests affected by all commits in the branch
  (by comparing against the branch point of the pull request)

```yaml
    # Get the commit where this branch diverges from origin/main
    - name: Retrieve branch point
      if: github.event_name == 'pull_request'
      run: |
        echo "::set-output name=KEY::$(diff -u <(git rev-list --first-parent origin/main) <(git rev-list --first-parent HEAD) | sed -ne 's/^ //p' | head -1)"
      id: cache_keys
    # Use the always-upload-cache action to:
    #  - Restore the flutter state from cache from either the branch point (if it was set in the previous step)
    #    or the last run in the current branch
    #  - After the run cache the flutter state using the current commit hash as the hash key
    - name: Setup flutter state
      id: flutter-state
      uses: pat-s/always-upload-cache@v2.1.5
      env:
        cache-name: cache-flutter-state
      with:
        path: .flutter
        key: ${{ runner.os }}-build-${{ env.cache-name }}-${{ matrix.ruby-version }}-${{ github.sha }}
        restore-keys: |
          ${{ runner.os }}-build-${{ env.cache-name }}-${{ matrix.ruby-version }}-${{ steps.cache_keys.outputs.KEY }}
    # If this is a push event on the main branch, clear the flutter state
    # so that all tests are run and a full state is cached on the main branch
    - name: Clear flutter state
      if: github.event_name == 'push' && startsWith(github.ref, 'refs/heads/main')
      run: rm -rf .flutter
```
> **Note**
> The exact CI configuration would ofcourse depend on your workflow and confidence in selectively
> running tests for pull requests.

> **Warning**
> Selectively running tests in a pull request would show a drop in coverage if you are collecting
> and/or using code coverage as a "Check". One way to make Flutter work hand in hand with code
> coverage checks is to only validate that the diff in the pull request has a 100% coverage. For
> example with [codecov](https://docs.codecov.com/docs/commit-status#section-project-status) this can be
> achieved by only enabling the `project` status for the main branch and `patch` status otherwise.

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
  - Patch release `bundle exec rake release["patch"]`
  - Minor release `bundle exec rake release["minor"]`
  - Major release `bundle exec rake release["major"]`
  > **Note**
  > The `release` rake task automates updating the changelog & version, committing the changes & creating a new tag
- Push the tag. The CI workflow for tag pushes will take care of publishing the gem & creating a github release.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/indydevs/flutter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/indydevs/flutter/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Flutter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/indydevs/flutter/blob/main/CODE_OF_CONDUCT.md).
