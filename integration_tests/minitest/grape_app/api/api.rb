require_relative './routes/trackable_object/api'
require_relative './routes/property/api'
require_relative './routes/event/api'
require_relative './routes/project/api'
require_relative './routes/change_request/api'
require_relative './routes/tracking_spec/api'
require_relative './routes/user/api'

module Skee
  module API
    class API < Grape::API
      version 'v1', using: :header, vendor: 'skee'
      format :json
      prefix :api

      rescue_from Skee::App::Utils::Errors::ValidationError do |e|
        error!(e, 400)
      end

      before do
        header 'Access-Control-Allow-Origin', '*'
        header 'Access-Control-Allow-Headers', 'content-type'
      end

      mount Skee::API::Routes::TrackableObject::API
      mount Skee::API::Routes::Property::API
      mount Skee::API::Routes::Event::API
      mount Skee::API::Routes::Project::API
      mount Skee::API::Routes::ChangeRequest::API
      mount Skee::API::Routes::TrackingSpec::API
      mount Skee::API::Routes::User::API
    end  
  end
end
