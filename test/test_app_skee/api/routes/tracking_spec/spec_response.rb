require_relative '../event/response_entity'
require_relative '../trackable_object/response_entity'
require_relative '../property/response_entity'

module Skee
  module API
    module Routes
      module TrackingSpec
        class SpecResponse < Grape::Entity
          expose :id, documentation: { type: 'String', desc: 'Unique ID of a tracking spec.' }
          expose :version_identifier, documentation: { type: 'String', desc: 'Identifier of a Tracking Spec.' }
          expose :name, documentation: { type: 'String', desc: 'Name of the tracking spec.' }
          expose :change_request_id, documentation: { type: 'String', desc: 'Change request ID for the tracking spec.' }
          expose :events, with: Skee::API::Routes::Event::ResponseEntity
        end
      end
    end
  end
end
