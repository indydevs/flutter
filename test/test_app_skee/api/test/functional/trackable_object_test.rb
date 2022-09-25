require_relative '../../../test/test_helper'
require_relative 'versioned_entity_helper'
module Skee
  module API
    module Test
      module Functional
        class TrackableObjectTest < MiniTest::Test
          include Rack::Test::Methods
          include Skee::API::Test::Functional::VersionedEntityHelper

          def app
            Skee::API::Routes::TrackableObject::API
          end

          def initialize_db
            @trackable_objects = Skee::Test::Fixtures::TrackableObjects.all
            @trackable_objects.each { |entity| Skee::DB::Proto::TrackableObject.create(entity) }
            @trackable_object_snapshots = Skee::Test::Fixtures::TrackableObjectSnapshots.all
            @trackable_object_snapshots.each { |entity| Skee::DB::Proto::TrackableObjectSnapshot.create(entity) }
            @change_requests = Skee::Test::Fixtures::ChangeRequests.all
            @change_requests.each { |entity| Skee::DB::Proto::ChangeRequest.create(entity) }
            @tracking_specs = Skee::Test::Fixtures::TrackingSpecs.all
            @tracking_specs.each { |entity| Skee::DB::Proto::TrackingSpec.create(entity) }
          end

          def clear_db
            Skee::DB::Proto::TrackableObject.delete_all
            Skee::DB::Proto::ChangeRequest.delete_all
            Skee::DB::Proto::TrackingSpec.delete_all
          end

          def setup
            clear_db
            initialize_db
            @entity_type = :trackable_object
            @entity_path = 'trackable_objects'
            @entity_fixture = Skee::Test::Fixtures::TrackableObjects
          end

          # def test_get_all_trackable_objects
          #   get_all_entities
          # end

          def test_retrieve_trackable_object
            id = '4'
            retrieve_entity(id)
          end

          def test_retrieve_trackable_object_with_change_request
            id = '4'
            snapshot_id = '5'
            params = {'change_request_id' => '1'}
            retrieved_entity = retrieve_entity(id, params)
            assert_equal(
              snapshot_id,
              retrieved_entity['snapshot_id']
            )
          end

          def test_create_trackable_object_invalid_change_request
            new_entity_params = {'name' => 'name', 'change_request_id' => '-999'}
            create_entity_invalid_change_request(new_entity_params)
          end

          def test_create_trackable_object_valid_name
            new_entity_params = {'name' => 'Cart', 'change_request_id' => '1'}
            create_entity_valid_name(new_entity_params)
          end

          def test_update_trackable_object_invalid_change_request
            id = '3'
            params = {'name' => 'name', 'change_request_id' => '-999'}
            update_entity_invalid_change_request(id, params)
          end

          def test_update_trackable_object_valid_creates_new_entity
            id = '3'
            snapshot_id = '5'
            params = {'name' => 'Cart', 'change_request_id' => '1'}
            updated_entity = update_entity_valid_creates_new_entity(id, params)
            assert_equal(
              params['name'],
              updated_entity['name']
            )
            assert_equal(snapshot_id, updated_entity['previous_snapshot_id'])
          end

          def test_update_trackable_object_valid_updates_existing_snapshot_of_updated_trackable_object
            id = '4'
            params = {'name' => 'All Shops', 'change_request_id' => '1'}
            updated_entity = update_entity_valid_updates_existing_snapshot_of_updated_entity(id, params)
            assert_equal(
              params['name'],
              updated_entity['name']
            )
          end

          def test_update_trackable_object_valid_updates_existing_snapshot_of_new_trackable_object
            id = '5'
            params = {'name' => 'Logged-in User', 'change_request_id' => '1'}
            updated_entity = update_entity_valid_updates_existing_snapshot_of_new_entity(id, params)
            assert_equal(
              params['name'],
              updated_entity['name']
            )
          end

          def test_remove_trackable_object_invalid_change_request
            id = '3'
            params = {'change_request_id' => '-999'}
            remove_entity_invalid_change_request(id, params)
          end

          def test_remove_trackable_object_valid_creates_new_entity
            id = '3'
            params = {'change_request_id' => '1'}
            remove_entity_valid_creates_new_entity(id, params)
          end

          def test_remove_trackable_object_valid_updates_existing_snapshot_of_updated_trackable_object
            id = '4'
            params = {'change_request_id' => '1'}
            remove_entity_valid_updates_existing_snapshot_of_updated_entity(id, params)
          end

          def test_remove_trackable_object_valid_updates_existing_snapshot_of_new_trackable_object
            id = '5'
            params = {'change_request_id' => '1'}
            remove_entity_valid_updates_existing_snapshot_of_new_entity(id, params)
          end
        end
      end
    end
  end
end