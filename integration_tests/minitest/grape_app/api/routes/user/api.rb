# typed: strict
require_relative '../api_helpers'
require_relative './response_entity'
require 'ostruct'

module Skee::API::Routes::User
  class API < Grape::API
    helpers Skee::API::Routes::APIHelpers

    resource :users do
      desc 'Authenticate a user'
      params do
        requires :username, type: String, desc: 'username of the user'
        requires :password, type: String, desc: 'password of the user'
      end
      post ':authenticate' do
        response = OpenStruct.new({ username: params[:username], access_token: '123' })
        present response,
          with: Skee::API::Routes::User::ResponseEntity
      end
    end
  end
end
