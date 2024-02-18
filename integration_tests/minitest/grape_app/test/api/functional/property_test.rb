# typed: true
require_relative '../../test_helper'
require_relative 'versioned_entity_helper'
module Skee
  module API
    module Test
      module Functional
        class PropertyTest < MiniTest::Test
          include Rack::Test::Methods
          include Skee::API::Test::Functional::VersionedEntityHelper

          def app
            Skee::API::Routes::Property::API
          end

          def initialize_db
            @properties = Skee::Test::Fixtures::Properties.all
            @properties.each { |entity| Skee::DB::Proto::Property.create(entity) }
            @property_snapshots = Skee::Test::Fixtures::PropertySnapshots.all
            @property_snapshots.each { |entity| Skee::DB::Proto::PropertySnapshot.create(entity) }
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
            Skee::DB::Proto::Property.delete_all
            Skee::DB::Proto::TrackableObject.delete_all
            Skee::DB::Proto::ChangeRequest.delete_all
            Skee::DB::Proto::TrackingSpec.delete_all
          end

          def setup
            clear_db
            initialize_db
            @entity_type = :property
            @entity_path = 'properties'
            @entity_fixture = Skee::Test::Fixtures::Properties
          end

          # def test_get_all_properties
          #   get_all_entities
          # end

          def test_retrieve_property
            id = '4'
            retrieve_entity(id)
          end

          def test_retrieve_property_with_change_request
            id = '4'
            snapshot_id = '5'
            params = {'change_request_id' => '1'}
            retrieved_entity = retrieve_entity(id, params)
            assert_equal(
              snapshot_id,
              retrieved_entity['snapshot_id']
            )
          end

          def test_create_property_invalid_change_request
            new_entity_params = {
              'name' => 'phone number',
              'property_of' => 'trackable_object',
              'change_request_id' => '-999',
              'parent_reference_id' => '1',
              'data_type' => 'String'
            }
            create_entity_invalid_change_request(new_entity_params)
          end

          def test_create_property_valid_for_updated_trackable_object
            trackable_object_id = '4'
            new_entity_params = {
              'name' => 'phone number',
              'property_of' => 'trackable_object',
              'change_request_id' => '1',
              'parent_reference_id' => trackable_object_id,
              'data_type' => 'String'
            }
            new_property = create_entity_valid_name(new_entity_params)
            trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id,
              change_request_id: new_entity_params['change_request_id']
            )
            assert_includes(trackable_object.versioned_entity_snapshot.property_ids, new_property['id'])
          end

          def test_create_property_valid_for_non_updated_trackable_object
            trackable_object_id = '1'
            change_request_id = '1'
            new_entity_params = {
              'name' => 'name',
              'property_of' => 'trackable_object',
              'change_request_id' => '1',
              'parent_reference_id' => trackable_object_id,
              'data_type' => 'String'
            }
            new_property = create_entity_valid_name(new_entity_params)
            old_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id
            )
            new_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id,
              change_request_id: new_entity_params['change_request_id']
            )
            refute_includes(old_trackable_object.versioned_entity_snapshot.property_ids, new_property['id'])
            assert_includes(new_trackable_object.versioned_entity_snapshot.property_ids, new_property['id'])
          end

          def test_update_property_belonging_to_non_updated_trackable_object
            property_id = '1'
            trackable_object_id = '1'
            change_request_id = '1'
            update_entity_params = {
              'name' => 'first_name',
              'property_of' => 'trackable_object',
              'change_request_id' => change_request_id,
              'parent_reference_id' => trackable_object_id,
              'data_type' => 'String'
            }
            updated_property = update_entity_valid_creates_new_entity(property_id, update_entity_params)

            old_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id
            )
            new_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id,
              change_request_id: update_entity_params['change_request_id']
            )
            assert_includes(old_trackable_object.versioned_entity_snapshot.property_ids, property_id)
            assert_includes(new_trackable_object.versioned_entity_snapshot.property_ids, property_id)
          end

          def test_update_previously_updated_property
            property_id = '1'
            trackable_object_id = '1'
            change_request_id = '1'
            update_entity_params = {
              'name' => 'first_name',
              'property_of' => 'trackable_object',
              'change_request_id' => change_request_id,
              'parent_reference_id' => trackable_object_id,
              'data_type' => 'String'
            }
            updated_property = update_entity_valid_creates_new_entity(property_id, update_entity_params)

            new_update_params = update_entity_params.merge(
              'name' => 'last_name',
            )

            new_updated_property = update_entity_valid_updates_existing_snapshot_of_updated_entity(property_id, new_update_params)

            old_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id
            )
            new_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id,
              change_request_id: update_entity_params['change_request_id']
            )
            assert_includes(old_trackable_object.versioned_entity_snapshot.property_ids, property_id)
            assert_includes(new_trackable_object.versioned_entity_snapshot.property_ids, property_id)
            assert_equal(new_update_params['name'], new_updated_property['name'])
            assert_equal(property_id, new_updated_property['id'])
            assert_equal(updated_property['id'], new_updated_property['id'])
            assert_equal(updated_property['snapshot_id'], new_updated_property['snapshot_id'])
          end

          def test_remove_property_belonging_to_non_updated_trackable_object
            property_id = '1'
            trackable_object_id = '1'
            change_request_id = '1'
            remove_entity_params = {
              'change_request_id' => change_request_id,
              'parent_reference_id' => trackable_object_id,
            }
            updated_property = remove_entity_valid_creates_new_entity(property_id, remove_entity_params)

            old_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id
            )
            new_trackable_object = Skee::App::TrackableObject::Service.get(
              id: trackable_object_id,
              change_request_id: remove_entity_params['change_request_id']
            )
            assert_includes(old_trackable_object.versioned_entity_snapshot.property_ids, property_id)
            assert_includes(new_trackable_object.versioned_entity_snapshot.property_ids, property_id)
          end
        end
      end
    end
  end
end