require_relative '../api_helpers'
require_relative './response_entity'
require_relative '../../../app/project/endpoint'
module Skee::API::Routes::Project
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :projects do
      desc 'List all projects.'
      get do
        projects = Skee::App::Project::Endpoint.list
        present projects,
                with: Skee::API::Routes::Project::ResponseEntity
      end

      desc 'Retrieve a project.'
      params do
        requires :id, type: String, desc: 'project ID.'
      end
      get ':id' do
        project = Skee::App::Project::Endpoint.get(whitelisted_params)
        present project,
                with: Skee::API::Routes::Project::ResponseEntity
      end

      desc 'Create a project.'
      params do
        requires :name, type: String, desc: 'project name.'
        optional :description, type: String, desc: 'project description.'
      end
      post do
        new_project = Skee::App::Project::Endpoint.create(whitelisted_params)
        present new_project,
                with: Skee::API::Routes::Project::ResponseEntity
      end

      desc 'Update a project.'
      params do
        requires :id, type: String, desc: 'project ID.'
        optional :name, type: String, desc: 'project name.'
        optional :description, type: String, desc: 'project description.'
      end
      post ':id' do
        updated_project = Skee::App::Project::Endpoint.update(whitelisted_params)
        present updated_project,
                with: Skee::API::Routes::Project::ResponseEntity
      end

      desc 'Delete a project.'
      params do
        requires :id, type: String, desc: 'project ID.'
      end
      delete ':id' do
        Skee::App::Project::Endpoint.delete(whitelisted_params)
        status 200
      end
    end
  end
end
