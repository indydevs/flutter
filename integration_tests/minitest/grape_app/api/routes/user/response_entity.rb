# typed: strict
module Skee
  module API
    module Routes
      module User
        class ResponseEntity < Grape::Entity
          expose :username, documentation: {type: 'String', desc: 'Username of the user'}
          expose :access_token, documentation: {type: 'String', desc: 'AccessToken for the user'}
        end
      end
    end
  end
end