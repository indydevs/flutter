# TODO

## Functionality
- [x] Changes to tests themselves do not re-trigger execution
    - [x] Minispec
    - [x] RSpec
- [ ] Changes in blocks or dynamically added functions based on blocks do not re-trigger execution

## Code quality
- [ ] Separate public/private API
- [ ] Add rdoc / yard documentation

## Testing
- [x] Improve test coverage
- [x] Add integration tests
- [ ] Test against large / complex codebases
    - [ ] Sidekiq (Minitest)
    - [ ] Discourse (RSpec)
## Performance
- [ ] Ensure only bare minimum signature calculation occurs
- [ ] Optimize inner loop of tracking test case -> method calls
- [ ] Evaluate alternate storage options (sqlite, leveldb..?)
    - [x] Marshal storage
- [ ] Evaluate using external hints for changes (for example when using with VCS)

## Usability
- [x] Quick start guide
- [x] Recipes for guard
- [ ] Recipes for CI

