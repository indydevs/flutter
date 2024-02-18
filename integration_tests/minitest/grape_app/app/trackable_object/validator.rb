# typed: true
require_relative '../../app/change_request/service'
require_relative '../../app/tracking_spec/service'
module Skee
  module App
    module TrackableObject
      class Validator
        def initialize(params)
          @params = params
        end

        ERRORS = Utils::Errors

        def validate_add_property
          validate_property_exists(@params[:property_id])
        end

        def validate_remove_property
          validate_property_exists(@params[:property_id])
          validate_property_belongs_to_trackable_object(@params[:property_id], @params[:id])
        end

        private

        def validate_property_exists(property_id)
          property_instance = Skee::App::DB_MAPPING_ENTITY[:property].find(property_id)
          raise ERRORS::RecordNotFoundException.new('Resource not found') unless property_instance
        end

        def validate_property_belongs_to_trackable_object(property_id, trackable_object_id)
          return if trackable_object(trackable_object_id).versioned_entity_snapshot.property_ids.include?(property_id)
          raise ERRORS::NotAllowedToUpdate.new('Trackable object does not contain property.')
        end

        def trackable_object(trackable_object_id)
          @trackable_object ||= Skee::App::TrackableObject::Service.get(id: trackable_object_id)
        end
      end
    end
  end
end