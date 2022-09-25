require 'rack/test'
require 'minitest/autorun'
require 'flutter'

require_relative '../config/boot'

Flutter.configure do |config|
  config.enabled = true
  config.sources = ["./app", "./test"] # The default is Dir.pwd
  config.storage_class = Flutter::Persistence::Yaml # This is the default
  config.storage_options = {path: "./flutter"} # This is the default
  config.reset_storage = false # This is the default
end


Dir.glob('**/fixtures/*.rb').each do |f|
  puts "Loading #{f}"
  require_relative "../#{f}" unless File.absolute_path(f) == __FILE__
end