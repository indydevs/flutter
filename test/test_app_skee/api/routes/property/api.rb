require_relative '../api_helpers'
require_relative './response_entity'
require_relative '../../../app/property/endpoint'
module Skee::API::Routes::Property
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :properties do
      desc 'List all properties.'
      get do
        properties = Skee::App::Property::Endpoint.list
        present properties,
                with: Skee::API::Routes::Property::ResponseEntity
      end

      desc 'Retrieve a property.'
      params do
        requires :id, type: String, desc: 'Property ID.'
        optional :change_request_id, type: String, desc: 'Change request ID for the request.'
      end
      get ':id' do
        property = Skee::App::Property::Endpoint.get(whitelisted_params)
        present property,
          with: Skee::API::Routes::Property::ResponseEntity
      end

      desc 'Create a property.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        requires :name, type: String, desc: 'Property name.'
        requires :property_of, type: Symbol, values: [:trackable_object, :event], desc: 'Specifies whether property is that of a trackable object or event'
        requires :data_type, type: String, desc: 'Data type of the property.'
        requires :parent_reference_id, type: String, desc: 'ID of the trackable object the property belongs to.'
        optional :description, type: String, desc: 'Description of the property.'
        optional :is_nullable, type: Boolean, desc: 'Is this property nullable when being passed in an event?.'
        optional :additional_instructions, type: String, desc: 'Additional instructions for the trackable object property.'
        optional :data_format_id, type: String, desc: 'FK to the data format of the property.'
        optional :regex_validation, type: String, desc: 'RegEx expression for validation of the property value sent.'
      end
      post do
        new_property = Skee::App::Property::Endpoint.create(whitelisted_params)
        present new_property,
          with: Skee::API::Routes::Property::ResponseEntity
      end

      desc 'Update a trackable object property.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        optional :parent_reference_id, type: String, desc: 'ID of the trackable object the property belongs to.'
        requires :id, type: String, desc: 'Property ID.'
        optional :name, type: String, desc: 'Property name.'
        optional :description, type: String, desc: 'Description of the property.'
        optional :is_nullable, type: Boolean, desc: 'Is this property nullable when being passed in an event?.'
        optional :data_type, type: String, desc: 'Data type of the property.'
        optional :additional_instructions, type: String, desc: 'Additional instructions for the property.'
        optional :data_format_id, type: String, desc: 'FK to the data format of the property.'
        optional :regex_validation, type: String, desc: 'RegEx expression for validation of the property value sent.'
      end
      post ':id' do
        updated_property = Skee::App::Property::Endpoint.update(whitelisted_params)
        present updated_property,
          with: Skee::API::Routes::Property::ResponseEntity
      end

      desc 'Remove a property from the tracking spec.'
      params do
        requires :change_request_id, type: String, desc: 'Change request ID for the request.'
        optional :parent_reference_id, type: String, desc: 'ID of the trackable object the property belongs to.'
        requires :id, type: String, desc: 'Property ID.'
      end
      post ':id/remove' do
        updated_property = Skee::App::Property::Endpoint.remove(whitelisted_params)
        present updated_property,
                with: Skee::API::Routes::Property::ResponseEntity
      end
    end
  end
end
