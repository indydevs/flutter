require_relative '../../app/versioned_entity/service'
require_relative 'validator'
module Skee
  module App
    module TrackableObject
      class Service < Skee::App::VersionedEntityService
        def self.entity
          :trackable_object
        end

        def self.create_fields_keys
          %i(
            change_request_id
            previous_snapshot_id
            is_removed
            name
            property_ids
          )
        end

        def self.update_fields_keys
          %i(
            change_request_id
            is_removed
            id
            name
            property_ids
          )
        end

        def self.add_property(params)
          Skee::App::TrackableObject::Validator.new(params).
            validate_add_property
          trackable_object = get(id: params[:id])
          trackable_object_property_ids = trackable_object.versioned_entity_snapshot.property_ids
          property_id = params[:property_id]

          return if trackable_object_property_ids.include?(property_id)
          update_property_ids = trackable_object_property_ids + [property_id]
          update(
            id: params[:id],
            property_ids: update_property_ids,
            change_request_id: params[:change_request_id]
          )
        end
      end
    end
  end
end