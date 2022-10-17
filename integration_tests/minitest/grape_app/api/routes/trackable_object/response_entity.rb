# typed: strict
module Skee
  module API
    module Routes
      module TrackableObject
        class ResponseEntity < Grape::Entity
          class VersionedEntity < Grape::Entity
            expose :id, documentation: { type: 'String', desc: 'Unique ID of a trackable_object.' }
          end
          class EntitySnapshot < Grape::Entity
            expose :id, as: :snapshot_id, documentation: { type: 'String', desc: 'Unique ID of a trackable_object.' }
            expose :name, documentation: { type: 'String', desc: 'Name of the trackable object.' }
            expose :change_request_id, documentation: { type: 'String', desc: 'Change request ID for the trackable object.' }
            expose :previous_snapshot_id, documentation: { type: 'String', desc: 'Trackable object ID of the previous version of this trackable object.' }
            expose :is_removed, safe: true, documentation: { type: 'String', desc: 'Marker to specify that trackable object is removed from the tracking spec.' }
            expose :property_ids, documentation: { type: 'Array', desc: 'Property IDs of a trackable object.' }
          end

          expose :versioned_entity, merge: true, using: ResponseEntity::VersionedEntity
          expose :versioned_entity_snapshot, merge: true, using: ResponseEntity::EntitySnapshot
        end
      end
    end
  end
end