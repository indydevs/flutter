# typed: strict
module Skee
  module API
    module Routes
      module TrackingSpec
        class ResponseEntity < Grape::Entity
          expose :id, documentation: { type: 'String', desc: 'Unique ID of a Tracking Spec.' }
          expose :version_identifier, documentation: { type: 'String', desc: 'Identifier of a Tracking Spec.' }
          expose :project_id, documentation: { type: 'String', desc: 'Project in which Tracking Spec created.' }
          expose :change_request_id, documentation: { type: 'String', desc: 'Change request from which Tracking Spec was created.' }
          expose :status, documentation: { type: 'String', desc: 'Status of a Tracking Spec.' }
          expose :name, documentation: { type: 'String', desc: 'Name of the Tracking Spec.' }
          expose :event_ids, documentation: { type: 'String', desc: 'Dictionary with list of IDs of all entities comprising the tracking spec.' }
        end
      end
    end
  end
end