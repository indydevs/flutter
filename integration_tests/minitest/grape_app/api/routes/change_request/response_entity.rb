# typed: strict
module Skee
  module API
    module Routes
      module ChangeRequest
        class ResponseEntity < Grape::Entity
          expose :id, documentation: { type: 'String', desc: 'Unique ID of a ChangeRequest.' }
          expose :identifier, documentation: { type: 'String', desc: 'Identifier of a ChangeRequest.' }
          expose :project_id, documentation: { type: 'String', desc: 'Project in which ChangeRequest created.' }
          expose :base_tracking_spec_id, documentation: { type: 'String', desc: 'ID of the Tracking Spec on which changes are requested.' }
          expose :status, documentation: { type: 'String', desc: 'Status of a ChangeRequest.' }
          expose :name, documentation: { type: 'String', desc: 'Name of the ChangeRequest.' }
          expose :description, documentation: { type: 'String', desc: 'Description of the ChangeRequest.' }
          expose :change_set, documentation: { type: 'String', desc: 'Dictionary with list of IDs of updated and new entities.' }
        end
      end
    end
  end
end