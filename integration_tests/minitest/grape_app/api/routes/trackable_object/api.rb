# typed: false
require_relative '../api_helpers'
require_relative './response_entity'
require_relative '../../../app/trackable_object/endpoint'
module Skee::API::Routes::TrackableObject
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :trackable_objects do
      desc 'List all trackable entitites.'
      get do
        trackable_objects = Skee::App::TrackableObject::Endpoint.list
        present trackable_objects,
                with: Skee::API::Routes::TrackableObject::ResponseEntity
      end

      desc 'Retrieve a trackable object.'
      params do
        requires :id, type: String, desc: 'Trackable object ID.'
        optional :change_request_id, type: String, desc: 'Change request ID for the request.'
      end
      get ':id' do
        trackable_object = Skee::App::TrackableObject::Endpoint.get(whitelisted_params)
        present trackable_object,
                with: Skee::API::Routes::TrackableObject::ResponseEntity
      end

      desc 'Create a trackable object.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :name, type: String, desc: 'Trackable object name.'
        optional :property_ids, type: Array[String], desc: 'Property IDs of a Trackable object.'
      end
      post do
        new_trackable_object = Skee::App::TrackableObject::Endpoint.create(whitelisted_params)
        present new_trackable_object,
                with: Skee::API::Routes::TrackableObject::ResponseEntity
      end

      desc 'Update a trackable object.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :id, type: String, desc: 'Trackable object ID.'
        optional :name, type: String, desc: 'Trackable object name.'
        optional :property_ids, type: Array[String], desc: 'Property IDs of a Trackable object.'
      end
      post ':id' do
        updated_trackable_object = Skee::App::TrackableObject::Endpoint.update(whitelisted_params)
        present updated_trackable_object,
                with: Skee::API::Routes::TrackableObject::ResponseEntity
      end

      desc 'Remove a trackable object from the tracking spec.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :id, type: String, desc: 'Trackable object ID.'
      end
      post ':id/remove' do
        updated_trackable_object = Skee::App::TrackableObject::Endpoint.remove(whitelisted_params)
        present updated_trackable_object,
                with: Skee::API::Routes::TrackableObject::ResponseEntity
      end
    end
  end
end
