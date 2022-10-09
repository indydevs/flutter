# typed: false
require_relative '../api_helpers'
require_relative './response_entity'
require_relative './spec_response'
require_relative '../../../app/tracking_spec/endpoint'

module Skee::API::Routes::TrackingSpec
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :tracking_specs do
      desc 'List all Tracking Specs.'
      get do
        tracking_specs = Skee::App::TrackingSpec::Endpoint.list
        present tracking_specs,
          with: Skee::API::Routes::TrackingSpec::ResponseEntity
      end

      desc 'Retrieve a Tracking Spec.'
      params do
        requires :id, type: String, desc: 'Tracking Spec ID.'
      end
      get ':id' do
        tracking_spec = Skee::App::TrackingSpec::Endpoint.get(whitelisted_params)
        present tracking_spec,
          with: Skee::API::Routes::TrackingSpec::ResponseEntity
      end

      desc 'Generate a full Tracking Spec.'
      params do
        requires :id, type: String, desc: 'Tracking Spec ID.'
      end
      get ':id/full_spec' do
        full_spec = Skee::App::TrackingSpec::Endpoint.full_spec(whitelisted_params)
        present full_spec,
          with: Skee::API::Routes::TrackingSpec::SpecResponse
      end

      desc 'Create a Tracking Spec.'
      params do
        requires :name, type: String, desc: 'Name of the Tracking Spec.'
        optional :version_identifier, type: String, desc: 'Identifier of a Tracking Spec.'
        optional :project_id, type: String, desc: 'Project in which Tracking Spec created.'
        optional :change_request_id, type: String, desc: 'Change request from which Tracking Spec was created.'
        optional :status, type: String, desc: 'Status of a Tracking Spec.'
        optional :event_ids, type: Array[String], desc: 'Array of event IDs.'
      end
      post do
        new_tracking_spec = Skee::App::TrackingSpec::Endpoint.create(whitelisted_params)
        present new_tracking_spec,
          with: Skee::API::Routes::TrackingSpec::ResponseEntity
      end

      desc 'Update a Tracking Spec.'
      params do
        requires :id, type: String, desc: 'Tracking Spec ID.'
        optional :name, type: String, desc: 'Name of the Tracking Spec.'
        optional :version_identifier, type: String, desc: 'Identifier of a Tracking Spec.'
        optional :project_id, type: String, desc: 'Project in which Tracking Spec created.'
        optional :change_request_id, type: String, desc: 'Change request from which Tracking Spec was created.'
        optional :status, type: String, desc: 'Status of a Tracking Spec.'
        optional :event_ids, type: Array[String], desc: 'Array of event IDs.'
      end
      post ':id' do
        updated_tracking_spec = Skee::App::TrackingSpec::Endpoint.update(whitelisted_params)
        present updated_tracking_spec,
          with: Skee::API::Routes::TrackingSpec::ResponseEntity
      end

      desc 'Delete a Tracking Spec.'
      params do
        requires :id, type: String, desc: 'Tracking Spec ID.'
      end
      delete ':id' do
        Skee::App::TrackingSpec::Endpoint.delete(whitelisted_params)
        status 200
      end

      desc 'Expand a Tracking Spec'
      params do
        requires :id, type: String, desc: 'Tracking Spec ID.'
        requires :change_request_id, type: String, desc: 'Change request from which Tracking Spec was created.'
      end
      get ':id/expand' do
        Skee::App::TrackingSpec::Endpoint.expand(whitelisted_params)
      end
    end
  end
end
