# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
## 0.3.0 - 2022-10-16
### Changed
- Switch from `pry` to `method_source` as the actual dependency for inspecting method sources for generating signatures

### Fixed
- Ensure partial test runs don't clobber source mappings for previously run test cases

## 0.2.6 - 2022-10-14
### Added
- Backward compatibilty hack for default values in `dry-configurable < 0.13`

## 0.2.5 - 2022-10-13
### Added
- Explicit dependency on `pry` for reflecting sources of methods
- Use source hints from coverage to include dynamically added classes in signature generation

## 0.2.4 - 2022-10-04
### Changed
- Relax version requirement for dry-configurable

## 0.2.3 - 2022-10-04
### Fixed
- Disable filtering when Flutter.enabled=false

## 0.2.2 - 2022-10-03
### Added
- Document configuration options in README

### Changed
- Delay requiring source files explicitely and only in the case where the constant cannot be found
- Ensure the previous test->coverage mapping is merged with current one when the test fails.

## 0.2.1
### Fixed
- Corrected integration examples for guard in README

## 0.2.0
### Added
- CI Recipe in README
- CI integration for incremental tests in branches/pull requests
- Release workflow tasks & github actions integration

### Fixed
- Ensure all methods (including inherited ones) are considered when calculating signatures for a class or module.
- Fix calculation of total / filtered examples for rspec integration

## 0.1.0.pre.3
### Added
- Improved documentation for Persistence classes
- Improved documentation for Tracker

### Changed
- Pinned dependencies to known working minimum versions

## 0.1.0.pre.2
### Added
- Minitest integration
- RSpec integration

