# typed: true
require_relative '../../app/change_request/service'
module Skee
  module App
    module VersionedEntity
      class Validator
        def initialize(params, entity_type)
          @params = params
          @entity_type = entity_type
        end

        ERRORS = Utils::Errors

        def validate_create_params
          validate_change_request_status
          validate_uniqueness_by_name
        end

        def validate_update_params
          validate_versioned_entity_present
          validate_change_request_status
          validate_uniqueness_by_name
        end

        def validate_remove_params
          validate_versioned_entity_present
          validate_change_request_status
          validate_uniqueness_by_name
        end

        private

        def validate_versioned_entity_present
          entity_instance = Skee::App::DB_MAPPING_ENTITY[@entity_type].find(@params[:id])
          raise ERRORS::RecordNotFoundException.new('Resource not found') unless entity_instance
        end

        def validate_change_request_status
          raise ERRORS::RecordNotFoundException.new('Invalid change request') unless change_request
          raise ERRORS::NotAllowedToUpdate.new('Invalid change request') if change_request.status != 'open'
        end

        def validate_uniqueness_by_name
          # todo: fix this when we know structure of tracking spec
          # tracking_spec = Skee::App::TrackingSpec::Service.get(id: change_request.source_tracking_spec_id)
          # existing_entity_ids = tracking_spec.entity_set[@entity_type]
          # new_entity_change_set = change_request.change_set[@entity_type]
          # return unless new_entity_change_set
          # new_entity_ids = new_entity_change_set.values.flatten
          # non_unique_name = Skee::App::DB_MAPPING_ENTITY[@entity_type].find_all(ids: (new_entity_ids + existing_entity_ids)).any? do |entity|
          #   entity.name == @params[:name]
          # end
          # raise ERRORS::UniquenessViolationException.new('Invalid name') if non_unique_name
        end

        def change_request
          @change_request ||= Skee::App::ChangeRequest::Service.get(id: @params[:change_request_id])
        end
      end
    end
  end
end