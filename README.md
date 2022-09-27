# Flutter
[![CI](https://github.com/indydevs/flutter/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/indydevs/flutter/actions/workflows/main.yml)
[![codecov](https://codecov.io/github/indydevs/flutter/branch/main/graph/badge.svg?token=XANF37D9C1)](https://codecov.io/github/indydevs/flutter)

```
 __   __
(  \,/  )
 \_ | _/
 (_/ \_)

```

Selectively run only the tests affected by changed files.

## Usage

### Minitest

- Add the gem as a dependency

  ```ruby
  gem "flutter", path: "$path_to/flutter"
  ```
- Include the plugin in your `test_helper.rb`:

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
  gem "flutter", path: "$path_to/flutter"
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

## Related work

Flutter is heavily inspired by [testmon](https://github.com/tarpas/pytest-testmon)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This project uses [overcommit](https://github.com/sds/overcommit) to enforce standards. Enable the precommit hooks in your local checkout by running: `overcommit --sign`

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO

### Functionality
- [x] Changes to tests themselves do not re-trigger execution
  - [x] Minispec
  - [x] RSpec
- [ ] Changes in blocks or dynamically added functions based on blocks do not re-trigger execution

### Code quality
- [ ] Separate public/private API
- [ ] Add rdoc / yard documentation

### Testing
- [x] Improve test coverage
- [x] Add integration tests
- [ ] Test against large / complex codebases
  - [ ] Sidekiq (Minitest)
  - [ ] Discourse (RSpec)
### Performance
- [ ] Ensure only bare minimum signature calculation occurs
- [ ] Optimize inner loop of tracking test case -> method calls
- [ ] Evaluate alternate storage options (sqlite, leveldb..?)
  - [x] Marshal storage
- [ ] Evaluate using external hints for changes (for example when using with VCS)

### Usability
- [ ] Quick start guide
- [x] Recipes for guard
- [ ] Recipes for CI

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/indydevs/flutter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/indydevs/flutter/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Flutter project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/indydevs/flutter/blob/main/CODE_OF_CONDUCT.md).
