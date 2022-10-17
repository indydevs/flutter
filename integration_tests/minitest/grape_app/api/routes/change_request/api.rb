# typed: false
require_relative '../api_helpers'
require_relative './response_entity'
require_relative '../tracking_spec/spec_response'
require_relative '../../../app/change_request/endpoint'

module Skee::API::Routes::ChangeRequest
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :change_requests do
      desc 'List all Change Requests.'
      get do
        change_requests = Skee::App::ChangeRequest::Endpoint.list
        present change_requests,
                with: Skee::API::Routes::ChangeRequest::ResponseEntity
      end

      desc 'Retrieve a Change Request.'
      params do
        requires :id, type: String, desc: 'Change Request ID.'
      end
      get ':id' do
        change_request = Skee::App::ChangeRequest::Endpoint.get(whitelisted_params)
        present change_request,
                with: Skee::API::Routes::ChangeRequest::ResponseEntity
      end

      desc 'Generate a full Tracking Spec with the changes in the Change Request.'
      params do
        requires :id, type: String, desc: 'Change Request ID.'
      end
      get ':id/full_spec' do
        full_spec = Skee::App::ChangeRequest::Endpoint.full_spec(whitelisted_params)
        present full_spec,
          with: Skee::API::Routes::TrackingSpec::SpecResponse
      end

      desc 'Create a Change Request.'
      params do
        requires :name, type: String, desc: 'Change Request name.'
      end
      post do
        new_change_request = Skee::App::ChangeRequest::Endpoint.create(whitelisted_params)
        present new_change_request,
                with: Skee::API::Routes::ChangeRequest::ResponseEntity
      end

      desc 'Update a Change Request.'
      params do
        requires :id, type: String, desc: 'Change Request ID.'
        optional :name, type: String, desc: 'Change Request name.'
      end
      post ':id' do
        updated_change_request = Skee::App::ChangeRequest::Endpoint.update(whitelisted_params)
        present updated_change_request,
                with: Skee::API::Routes::ChangeRequest::ResponseEntity
      end

      desc 'Delete a Change Request.'
      params do
        requires :id, type: String, desc: 'Change Request ID.'
      end
      delete ':id' do
        Skee::App::ChangeRequest::Endpoint.delete(whitelisted_params)
        status 200
      end
    end
  end
end
