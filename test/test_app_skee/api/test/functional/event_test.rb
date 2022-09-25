require_relative '../../../test/test_helper'
require_relative 'versioned_entity_helper'
module Skee
  module API
    module Test
      module Functional
        class EventTest < MiniTest::Test
          include Rack::Test::Methods
          include Skee::API::Test::Functional::VersionedEntityHelper

          def app
            Skee::API::Routes::Event::API
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
            @events = Skee::Test::Fixtures::Events.all
            @events.each { |entity| Skee::DB::Proto::Event.create(entity) }
            @event_snapshots = Skee::Test::Fixtures::EventSnapshots.all
            @event_snapshots.each { |entity| Skee::DB::Proto::EventSnapshot.create(entity) }
          end

          def clear_db
            Skee::DB::Proto::Property.delete_all
            Skee::DB::Proto::TrackableObject.delete_all
            Skee::DB::Proto::ChangeRequest.delete_all
            Skee::DB::Proto::TrackingSpec.delete_all
            Skee::DB::Proto::Event.delete_all
          end

          def setup
            clear_db
            initialize_db
            @entity_type = :event
            @entity_path = 'events'
            @entity_fixture = Skee::Test::Fixtures::Events
          end

          # def test_get_all_events
          #   get_all_entities
          # end

          def test_retrieve_event
            id = '4'
            retrieve_entity(id)
          end

          def test_retrieve_event_with_change_request
            id = '4'
            snapshot_id = '5'
            params = {'change_request_id' => '1'}
            retrieved_entity = retrieve_entity(id, params)
            assert_equal(
              snapshot_id,
              retrieved_entity['snapshot_id']
            )
          end

          def new_event_params
            {
              'change_request_id' => '1',
              'name' => 'Launched App',
              'description' => 'Description of event A.',
              'payload' => [
                {
                  'key' => 'secondary_user',
                  'reference_entity_type' => 'trackable_object',
                  'reference_entity_id' => '1',
                  'is_array' => false,
                  'is_primary' => true,
                  'selected_property_ids' => ['1'],
                },
                {
                  'key' => 'created_timestamp',
                  'reference_entity_type' => 'property',
                  'reference_entity_id' => '2',
                  'is_array' => false,
                  'is_flatten' => false,
                  'is_primary' => nil,
                  'selected_property_ids' => ['2']
                },
              ]
            }
          end

          def update_event_params
            {
              'change_request_id' => '1',
              'name' => 'Exited App',
              'description' => 'Description of updated event A.',
            }
          end

          def update_event_payload_params
            {
              'change_request_id' => '1',
              'payload' => [
                {
                  'key' => 'primary_user',
                  'reference_entity_type' => 'trackable_object',
                  'reference_entity_id' => '1',
                  'is_array' => false,
                  'is_primary' => false,
                  'selected_property_ids' => ['1'],
                },
              ]
            }
          end

          def add_event_payload_params
            {
              'change_request_id' => '1',
              'payload' => [
                {
                  'key' => 'favorite_products',
                  'reference_entity_type' => 'trackable_object',
                  'reference_entity_id' => '2',
                  'is_array' => true,
                  'is_primary' => false,
                  'selected_property_ids' => ['4'],
                },
              ]
            }
          end

          def test_create_event_invalid_change_request
            params = new_event_params.merge('change_request_id' => -999)
            create_entity_invalid_change_request(params)
          end

          def test_create_event_valid
            create_entity_valid_name(new_event_params)
          end

          def test_update_event_invalid_change_request
            params = update_event_params.merge('change_request_id' => -999)
            update_entity_invalid_change_request('1', params)
          end

          def test_add_trackable_object_to_payload
            id = '1'
            post "/api/events/#{id}/add_payload", add_event_payload_params
            updated_event = JSON.parse(last_response.body)
            change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find('1')
            assert_equal(updated_event['snapshot_id'], change_request.change_set[:event][id].values.first)
            updated_payload = updated_event['payload'].find { |payload| payload['key'] == 'favorite_products'}
            assert_equal(4, updated_event['payload'].count)
            assert_equal('2', updated_payload['reference_entity_id'])
          end

          def test_update_trackable_object_in_payload
            id = '1'
            post "/api/events/#{id}/update_payload", update_event_payload_params
            updated_event = JSON.parse(last_response.body)
            change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find('1')
            assert_equal(updated_event['snapshot_id'], change_request.change_set[:event][id].values.first)
            updated_payload = updated_event['payload'].find { |payload| payload['key'] == 'primary_user'}
            assert_equal(3, updated_event['payload'].count)
            assert_equal('1', updated_payload['reference_entity_id'])
          end

          def test_remove_payload_identifier_from_payload
            id = '1'
            remove_payload_params = { 'change_request_id' => '1', 'payload_keys' => ['primary_user'] }
            post "/api/events/#{id}/remove_payload", remove_payload_params
            updated_event = JSON.parse(last_response.body)
            change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find('1')
            assert_equal(updated_event['snapshot_id'], change_request.change_set[:event][id].values.first)
            assert_equal(2, updated_event['payload'].count)
          end
        end
      end
    end
  end
end