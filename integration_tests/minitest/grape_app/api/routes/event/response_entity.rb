# typed: true
module Skee
  module API
    module Routes
      module Event
        class ResponseEntity < Grape::Entity
          class EventPayload < Grape::Entity
            expose :key, documentation: { type: 'String', desc: 'Key associated with the event.' }
            expose :reference_entity_type, documentation: { type: 'String', desc: 'Reference Entity type, either trackable object or event' }
            expose :reference_entity_id, documentation: { type: 'String', desc: 'Reference Entity ID' }
            expose :is_array, documentation: { type: 'Boolean', desc: 'Defines if the response is an array or singular object.' }
            expose :is_primary, documentation: { type: 'Boolean', desc: 'Defines if the entity is primary entity.'}
            expose :selected_property_ids, documentation: { type: 'Array', desc: 'Defines the IDs of the sub-properties of the key'}
          end

          class VersionedEntity < Grape::Entity
            expose :id, documentation: { type: 'String', desc: 'Unique ID of a property.' }
          end
          class EntitySnapshot < Grape::Entity
            expose :id, as: :snapshot_id, documentation: { type: 'String', desc: 'Unique ID of a event snapshot.' }
            expose :change_request_id, documentation: { type: 'String', desc: 'Change request ID of the event snapshot.' }
            expose :previous_snapshot_id, documentation: { type: 'String', desc: 'Snapshot ID of the previous version of the event.' }
            expose :is_removed, safe: true, documentation: { type: 'String', desc: 'Flag to specify that event is removed from the tracking spec.' }

            expose :name, documentation: { type: 'String', desc: 'Event name.' }
            expose :description, documentation: { type: 'String', desc: 'Description of the event.' }
            expose :payload, using: ResponseEntity::EventPayload

            def payload
              object.payload.map do |key, value|
                value.merge(key: key)
              end
            end
          end

          expose :versioned_entity, merge: true, using: ResponseEntity::VersionedEntity
          expose :versioned_entity_snapshot, merge: true, using: ResponseEntity::EntitySnapshot
        end
      end
    end  
  end
end
