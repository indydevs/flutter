require_relative '../../test_helper'
module Skee
  module API
    module Test
      module Functional
        class UserTest < MiniTest::Test
          i_suck_and_my_tests_are_order_dependent!

          include Rack::Test::Methods

          def app
            Skee::API::Routes::User::API
          end

          def test_authenticate
            post '/api/users/authenticate', username: 'user', password: 'password'
            assert last_response.created?
            body = JSON.parse(last_response.body)
            assert_equal('user', body['username'])
            assert_equal('123', body['access_token'])
          end
        end
      end
    end
  end
end