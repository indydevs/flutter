# Titli
[![CI](https://github.com/indydevs/titli/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/indydevs/titli/actions/workflows/main.yml)
[![codecov](https://codecov.io/github/indydevs/titli/branch/main/graph/badge.svg?token=XANF37D9C1)](https://codecov.io/github/indydevs/titli)

```
 __   __
(  \,/  )
 \_ | _/
 (_/ \_)
```


## Usage

## Minitest

- Add the gem as a dependency
  ```ruby
  gem "titli", path: "$path_to/titli"
  ```
- Enable the plugin with `TESTOPTS='--titli'` when running `bundle exec rake test`
- To start from scratch use `TESTOPTS='--titli --titli-reset'` to clear any persisted
  state and regenerate the source mappings for previous test runs

## RSpec

- Add the gem as a dependency:
  ```ruby
  gem "titli", path: "$path_to/titli"
  ```
- Include the plugin in your `spec_helper.rb`:
  ```ruby
  require 'titli/rspec'
  ```
- Enable & configure it in your `spec_helper.rb`:
  ```ruby
  Titli::RSpec.configure do |config|
    config.enabled = true # This is the default
    config.sources << "./app"
    config.storage_class = Titli::Persistence::SimpleStorage # (this is the default)
    config.storage_options = {path: "./titli"} # This is the default
    config.reset_storage = false # this is the default
  end
  ```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This project uses [overcommit](https://github.com/sds/overcommit) to enforce standards. Enable the precommit hooks in your local checkout by running: `overcommit --sign`

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/indydevs/titli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/indydevs/titli/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Titli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/indydevs/titli/blob/main/CODE_OF_CONDUCT.md).
