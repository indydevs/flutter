# typed: true
require_relative './utils/errors/api_exceptions'
require_relative './utils/errors/service_exceptions'

require_relative '../db/proto/project'
require_relative '../db/proto/change_request'

require_relative '../db/proto/event'
require_relative '../db/proto/event_snapshot'
require_relative '../db/proto/trackable_object'
require_relative '../db/proto/trackable_object_snapshot'
require_relative '../db/proto/property'
require_relative '../db/proto/property_snapshot'

module Skee
  module App
    DB = Skee::DB::Proto
    DB_MAPPING_ENTITY = {
      change_request: Skee::DB::Proto::ChangeRequest,
      event: Skee::DB::Proto::Event,
      project: Skee::DB::Proto::Project,
      trackable_object: Skee::DB::Proto::TrackableObject,
      property: Skee::DB::Proto::Property,
    }.freeze
    DB_MAPPING_ENTITY_SNAPSHOT = {
      event: Skee::DB::Proto::EventSnapshot,
      trackable_object: Skee::DB::Proto::TrackableObjectSnapshot,
      property: Skee::DB::Proto::PropertySnapshot,
    }.freeze
  end
end
