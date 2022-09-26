require 'rack/test'
require 'minitest/autorun'
require 'flutter'
require 'flutter/persistence'

require_relative '../config/boot'

Flutter.configure do |config|
  config.enabled = true
end


Dir.glob(File.join(__dir__, 'fixtures/*.rb')).each do |f|
  require_relative f unless File.absolute_path(f) == __FILE__
end
