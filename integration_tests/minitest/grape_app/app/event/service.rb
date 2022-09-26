require_relative '../../app/versioned_entity/service'
require_relative 'validator'
module Skee
  module App
    module Event
      class Service < Skee::App::VersionedEntityService
        def self.entity
          :event
        end

        def self.create_fields_keys
          %i(
            change_request_id
            previous_snapshot_id
            is_removed
            name
            description
            payload
          )
        end

        def self.update_fields_keys
          %i(
            id
            change_request_id
            is_removed
            name
            description
            payload
          )
        end

        def self.create(params)
          Skee::App::Event::Validator.new(params).validate_create_params
          super(params)
        end

        def self.add_payload_keys(params)
          Skee::App::Event::Validator.new(params).validate_add_payload_key_params
          event = Skee::App::Event::Service.get(id: params[:id])
          new_payload = event.versioned_entity_snapshot.payload.merge(params[:payload])
          params[:payload] = new_payload
          update(params)
        end

        def self.update_payload_keys(params)
          Skee::App::Event::Validator.new(params).validate_update_payload_key_params
          event = Skee::App::Event::Service.get(id: params[:id])
          new_payload = event.versioned_entity_snapshot.payload.merge(params[:payload])
          params[:payload] = new_payload
          update(params)
        end

        def self.remove_payload_keys(params)
          Skee::App::Event::Validator.new(params).validate_remove_payload_key_params
          event = Skee::App::Event::Service.get(id: params[:id])
          keys_for_removal = params[:payload_keys]
          new_payload = event.versioned_entity_snapshot.payload.map { |key, value|
            [key, value] unless keys_for_removal.include?(key)
          }.compact.to_h
          params[:payload] = new_payload
          params.delete(:payload_keys)
          update(params)
        end
      end
    end
  end
end
