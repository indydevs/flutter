# typed: false
require_relative './service'
require_relative './validator'
require_relative './expand_tracking_spec_events'

module Skee::App::TrackingSpec
  class Endpoint
    ERRORS = Skee::App::Utils::Errors

    def self.list
      Service.list
    end

    def self.get(params)
      Service.get(params)
    end

    def self.full_spec(params)
      Service.full_spec(params)
    end

    def self.create(params)
      Service.create(params)
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.update(params)
      Service.update(params)
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.delete(params)
      Service.delete(params)
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.expand(params)
      Skee::App::TrackingSpec::Validator.new(params).validate_expand_params
      tracking_spec = Service.get(params)
      expanded_events = ExpandTrackingSpecEvents.new(tracking_spec, params[:change_request_id]).perform
      OpenStruct.new(
        id: tracking_spec.id,
        identifier: tracking_spec.identifier,
        version: tracking_spec.version,
        project_id: tracking_spec.project_id,
        status: tracking_spec.status,
        events: expanded_events
      )
    rescue ERRORS::RecordNotFoundException => e
      raise ERRORS::ValidationError.new(e.message)
    end
  end
end