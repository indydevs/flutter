require_relative '../../app/versioned_entity/service'
module Skee
  module App
    module Property
      class Service < Skee::App::VersionedEntityService
        def self.entity
          :property
        end

        def self.create_fields_keys
          %i(
            change_request_id
            previous_snapshot_id
            is_removed
            name
            property_of
            description
            is_nullable
            data_type
            additional_instructions
            data_format_id
            regex_validation
          )
        end

        def self.update_fields_keys
          %i(
            change_request_id
            is_removed
            id
            name
            description
            is_nullable
            data_type
            additional_instructions
            data_format_id
            regex_validation
          )
        end

        def self.create(params)
          new_property = super(params)
          if params[:property_of] == :trackable_object
            parent_reference_id = params[:parent_reference_id]
            Skee::App::TrackableObject::Service.add_property(
              change_request_id: params[:change_request_id],
              id: parent_reference_id,
              property_id: new_property.versioned_entity.id
            )
          end
          new_property
        end
      end
    end
  end
end
