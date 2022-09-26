require_relative '../../app/change_request/service'
require_relative '../../app/tracking_spec/service'
module Skee
  module App
    module Event
      class Validator
        def initialize(params)
          @params = params
        end

        ERRORS = Utils::Errors

        def validate_create_params
          validate_change_request_status
          validate_payload
        end

        def validate_add_payload_key_params
          validate_change_request_status
          validate_non_duplicate_keys
          validate_payload
        end

        def validate_update_payload_key_params
          validate_change_request_status
          validate_key_exists(@params[:payload].keys)
          validate_payload
        end

        def validate_remove_payload_key_params
          validate_change_request_status
          validate_key_exists(@params[:payload_keys])
        end

        private

        def validate_payload
          payload = @params[:payload]
          return unless payload

          payload.each do |_, value|
            validate_reference_entity_and_type(value)
            validate_properties_exist_on_trackable_object(value)
            validate_selected_property_ids_exist(value)
          end
        end

        def validate_reference_entity_and_type(payload_value)
          reference_entity_id = payload_value[:reference_entity_id]
          reference_entity_type = payload_value[:reference_entity_type]

          reference_entity = if reference_entity_type == 'trackable_object'
            Skee::App::TrackableObject::Service.get(id: reference_entity_id, change_request_id: @params[:change_request_id])
          else
            Skee::App::Property::Service.get(id: reference_entity_id, change_request_id: @params[:change_request_id])
          end
          return if reference_entity

          raise ERRORS::NotAllowedToUpdate.new('Invalid parameter: Reference entity does not exist')
        end

        def validate_properties_exist_on_trackable_object(payload_value)
          return if payload_value[:reference_entity_type] != 'trackable_object'
          trackable_object = Skee::App::TrackableObject::Service.get(id: payload_value[:reference_entity_id], change_request_id: @params[:change_request_id])
          return if (payload_value[:selected_property_ids] - trackable_object.versioned_entity_snapshot.property_ids).empty?
          raise ERRORS::NotAllowedToUpdate.new('Invalid parameter: Selected properties not present on trackable object')
        end

        def validate_selected_property_ids_exist(payload_value)
          selected_property_ids = payload_value[:selected_property_ids]
          selected_properties = Skee::App::Property::Service.list(ids: selected_property_ids, change_request_id: @params[:change_request_id])
          return if (selected_properties.map{|property| property.versioned_entity.id} - selected_property_ids).empty?
          raise ERRORS::NotAllowedToUpdate.new('Invalid parameter: Selected properties do not exist')
        end

        def validate_non_duplicate_keys
          # check that key is unique
          # check that reference_entity_id exists for the corresponding reference_entity_type
          # check that selected_property_ids exist
          common_keys = event.versioned_entity_snapshot.payload.keys & @params[:payload].keys
          return if common_keys.empty?
          raise ERRORS::NotAllowedToUpdate.new("Invalid keys: Keys #{common_keys.join(',')} already exist")
        end

        def validate_key_exists(payload_keys)
          existing_keys = event.versioned_entity_snapshot.payload.keys
          payload_keys.each do |key|
            next if existing_keys.include?(key)
            raise ERRORS::NotAllowedToUpdate.new("Invalid keys: Not allowed to update non-existent key #{key}")
          end
        end

        def validate_change_request_status
          raise ERRORS::RecordNotFoundException.new('Invalid change request') unless change_request
          raise ERRORS::NotAllowedToUpdate.new('Invalid change request') if change_request.status != 'open'
        end

        def event
          @event ||= Skee::App::Event::Service.get(id: @params[:id], change_request_id: @params[:change_request_id])
        end

        def change_request
          @change_request ||= Skee::App::ChangeRequest::Service.get(id: @params[:change_request_id])
        end
      end
    end
  end
end