# typed: false
require_relative '../api_helpers'
require_relative './response_entity'
require_relative '../../../app/event/endpoint'
module Skee::API::Routes::Event
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :events do
      desc 'List all events.'
      get do
        events = Skee::App::Event::Endpoint.list
        present events,
          with: Skee::API::Routes::Event::ResponseEntity
      end

      desc 'Retrieve an event.'
      params do
        requires :id, type: String, desc: 'Event ID.'
        optional :change_request_id, type: String, desc: 'Change request ID for the request.'
      end
      get ':id' do
        event = Skee::App::Event::Endpoint.get(whitelisted_params)
        present event,
          with: Skee::API::Routes::Event::ResponseEntity
      end

      desc 'Create an event.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :name, type: String, desc: 'Event name.'
        optional :description, type: String, desc: 'Description of the event.'
        requires :payload, type: Array do
          requires :key, type: String, desc: 'Key of the event.'
          requires :reference_entity_type, type: String, desc: 'Type of reference entity: trackable object or property'
          requires :reference_entity_id, type: String, desc: 'ID of the reference entity.'
          requires :is_array, type: Boolean, desc: 'Defines if the reference entity is an array or singular object'
          requires :is_primary, type: Boolean, desc: 'Defines if the payload key is primary'
          requires :selected_property_ids, type: Array[String], desc: 'Defines the array of property IDs that the key contains'
        end
      end
      post do
          new_event = Skee::App::Event::Endpoint.create(whitelisted_params)
          present new_event,
          with: Skee::API::Routes::Event::ResponseEntity
      end
        
      desc 'Update an event.'
      params do
        requires :id, type: String, desc: 'Event ID.'
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        optional :name, type: String, desc: 'Event name.'
        optional :description, type: String, desc: 'Description of the event.'
     end
      post ':id' do
        updated_event = Skee::App::Event::Endpoint.update(whitelisted_params)
        present updated_event,
          with: Skee::API::Routes::Event::ResponseEntity
      end

      desc 'Add payload keys to an event.'
      params do
        requires :id, type: String, desc: 'Event ID.'
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :payload, type: Array do
          requires :key, type: String, desc: 'Key of the event.'
          requires :reference_entity_type, type: String, desc: 'Type of reference entity: trackable object or property'
          requires :reference_entity_id, type: String, desc: 'ID of the reference entity.'
          requires :is_array, type: Boolean, desc: 'Defines if the reference entity is an array or singular object'
          requires :is_primary, type: Boolean, desc: 'Defines if the payload key is primary'
          requires :selected_property_ids, type: Array[String], desc: 'Defines the array of property IDs that the key contains'
        end
      end
      post ':id/add_payload' do
        updated_event = Skee::App::Event::Endpoint.add_payload_keys(whitelisted_params)
        present updated_event,
          with: Skee::API::Routes::Event::ResponseEntity
      end

      desc 'Update payload for the given keys.'
      params do
        requires :id, type: String, desc: 'Event ID.'
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :payload, type: Array do
          requires :key, type: String, desc: 'Key of the event.'
          requires :reference_entity_type, type: String, desc: 'Type of reference entity: trackable object or property'
          requires :reference_entity_id, type: String, desc: 'ID of the reference entity.'
          requires :is_array, type: Boolean, desc: 'Defines if the reference entity is an array or singular object'
          requires :is_primary, type: Boolean, desc: 'Defines if the payload key is primary'
          requires :selected_property_ids, type: Array[String], desc: 'Defines the array of property IDs that the key contains'
        end
      end
      post ':id/update_payload' do
        updated_event = Skee::App::Event::Endpoint.update_payload_keys(whitelisted_params)
        present updated_event,
          with: Skee::API::Routes::Event::ResponseEntity
      end

      desc 'Remove keys from the payload.'
      params do
        requires :id, type: String, desc: 'Event ID.'
        requires :payload_keys, type: Array, desc: 'List of keys to be removed'
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
      end
      post ':id/remove_payload' do
        updated_event = Skee::App::Event::Endpoint.remove_payload_keys(whitelisted_params)
        present updated_event,
          with: Skee::API::Routes::Event::ResponseEntity
      end

      desc 'Remove an event from the tracking spec.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :id, type: String, desc: 'Event ID.'
      end
      post ':id/remove' do
        Skee::App::Event::Endpoint.remove(whitelisted_params)
        status 200
      end
    end
  end
end
