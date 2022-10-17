# typed: true
require_relative '../../app/change_request/service'
module Skee
  module App
    module TrackingSpec
      class Validator
        def initialize(params)
          @params = params
        end

        ERRORS = Utils::Errors

        def validate_create_params
          validate_unique_version_identifier
          validate_event_ids_exist
        end

        def validate_update_params
          validate_unique_version_identifier
          validate_tracking_spec_exists
          validate_event_ids_exist
        end

        def validate_expand_params
          validate_change_request
        end

        private

        def validate_unique_version_identifier
          return unless @params[:version_identifier]
          tracking_spec = Skee::App::TrackingSpec::Service.find_by(
            version_identifier: @params[:version_identifier]
          )
          return unless tracking_spec
          raise ERRORS::NotAllowedToUpdate.new('Invalid parameter: Version Identifier should be unique.')
        end

        def validate_tracking_spec_exists
          tracking_spec = Skee::App::TrackingSpec::Service.get(id: @params[:id])
          return if tracking_spec
          raise ERRORS::RecordNotFoundException.new('Invalid parameter: Tracking spec does not exist')
        end

        def validate_event_ids_exist
          return if @params[:event_ids].empty?
          events = Skee::App::Event::Service.list(ids: @params[:event_ids])
          return if (@params[:event_ids] - events.map(&:id)).empty?
          raise ERRORS::NotAllowedToUpdate.new('Invalid parameter: Event IDs do not exist')
        end

        def validate_change_request
          raise ERRORS::RecordNotFoundException.new('Invalid change request') unless change_request
        end

        def change_request
          @change_request ||= Skee::App::ChangeRequest::Service.get(id: @params[:change_request_id])
        end
      end
    end
  end
end