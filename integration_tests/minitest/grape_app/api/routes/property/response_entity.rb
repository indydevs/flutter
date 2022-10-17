# typed: strict
module Skee
  module API
    module Routes
      module Property
        class ResponseEntity < Grape::Entity
          class VersionedEntity < Grape::Entity
            expose :id, documentation: { type: 'String', desc: 'Unique ID of a property.' }
          end
          class EntitySnapshot < Grape::Entity
            expose :id, as: :snapshot_id, documentation: { type: 'String', desc: 'Unique ID of a property snapshot.' }
            expose :change_request_id, documentation: { type: 'String', desc: 'Change request ID of the property snapshot.' }
            expose :previous_snapshot_id, documentation: { type: 'String', desc: 'Snapshot ID of the previous version of the property.' }
            expose :is_removed, safe: true, documentation: { type: 'String', desc: 'Flag to specify that property is removed from the tracking spec.' }
            
            expose :name, documentation: { type: 'String', desc: 'Name of the property.' }
            expose :property_of, documentation: { type: 'String', desc: 'Specifies whether property is that of a trackable object or event' }
            expose :data_type, documentation: { type: 'String', desc: 'Data type of the property.' }
            expose :description, documentation: { type: 'String', desc: 'Description of the property.' }
            expose :is_nullable, documentation: { type: 'Boolean', desc: 'Is this property nullable when being passed in an event?.' }
            expose :additional_instructions, documentation: { type: 'String', desc: 'Additional instructions for the property.' }
            expose :data_format_id, documentation: { type: 'String', desc: 'FK to the data format of the property.' }
            expose :regex_validation, documentation: { type: 'String', desc: 'RegEx expression for validation of the property value sent.' }
          end

          expose :versioned_entity, merge: true, using: ResponseEntity::VersionedEntity
          expose :versioned_entity_snapshot, merge: true, using: ResponseEntity::EntitySnapshot
        end
      end
    end
  end
end