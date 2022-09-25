require_relative '../../../test/test_helper'
module Skee
  module API
    module Test
      module Functional
        module VersionedEntityHelper

          def get_all_entities
            get "/api/#{@entity_path}"
            assert last_response.ok?
            expected_entity_ids = @entity_fixture.all.map{ |e| e[:id] }
            response_entity_ids = JSON.parse(last_response.body).map{ |e| e['id'] }
            assert_empty(expected_entity_ids - response_entity_ids)
          end

          def retrieve_entity(id, params=nil)
            get "/api/#{@entity_path}/#{id}", params
            retrieved_entity = JSON.parse(last_response.body)
            assert last_response.ok?
            assert_equal(
              id,
              retrieved_entity['id']
            )
            retrieved_entity
          end

          def create_entity_invalid_change_request(new_entity_params)
            post "/api/#{@entity_path}", new_entity_params
            assert_equal(400, last_response.status)
            assert_equal(
              "{\"error\":\"Invalid change request\"}",
              last_response.body
            )
          end

          def create_entity_valid_name(new_entity_params)
            post "/api/#{@entity_path}", new_entity_params
            change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(new_entity_params['change_request_id'])
            new_entity = JSON.parse(last_response.body)
            assert_equal(201,last_response.status)
            assert_equal(
              new_entity_params['name'],
              new_entity['name']
            )
            assert_includes(change_request.change_set[@entity_type][new_entity['id']].values, new_entity['snapshot_id'])
            new_entity
          end

          def update_entity_invalid_change_request(id, update_params)
            post "/api/#{@entity_path}/#{id}", update_params
            assert_equal(400, last_response.status)
            assert_equal(
              "{\"error\":\"Invalid change request\"}",
              last_response.body
            )
          end

          def update_entity_valid_creates_new_entity(id, update_params)
            post "/api/#{@entity_path}/#{id}", update_params
            change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(update_params['change_request_id'])
            updated_entity = JSON.parse(last_response.body)
            assert_equal(201, last_response.status)
            assert_equal(id, updated_entity['id'])
            assert_includes(change_request.change_set[@entity_type].keys, id)
            assert_equal(change_request.change_set[@entity_type][id].values.first, updated_entity['snapshot_id'])
            assert_equal(change_request.change_set[@entity_type][id].keys.first, updated_entity['previous_snapshot_id'])
            updated_entity
          end

          def update_entity_valid_updates_existing_snapshot_of_updated_entity(id, update_params)
            old_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(update_params['change_request_id'])
            post "/api/#{@entity_path}/#{id}", update_params
            updated_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(update_params['change_request_id'])
            updated_entity = JSON.parse(last_response.body)
            assert_equal(201, last_response.status)
            assert_equal(id, updated_entity['id'])
            assert_includes(updated_change_request.change_set[@entity_type].keys, id)
            assert_equal(updated_change_request.change_set[@entity_type][id].values.first, 
              old_change_request.change_set[@entity_type][id].values.first)
            assert_equal(updated_change_request.change_set[@entity_type][id].keys.first, 
              old_change_request.change_set[@entity_type][id].keys.first)
            updated_entity
          end

          def update_entity_valid_updates_existing_snapshot_of_new_entity(id, update_params)
            old_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(update_params['change_request_id'])
            post "/api/#{@entity_path}/#{id}", update_params
            updated_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(update_params['change_request_id'])
            updated_entity = JSON.parse(last_response.body)
            assert_equal(201, last_response.status)
            assert_equal(id, updated_entity['id'])
            assert_includes(updated_change_request.change_set[@entity_type].keys, id)
            assert_equal(old_change_request.change_set[@entity_type][id].values.first,
              updated_change_request.change_set[@entity_type][id].values.first)
            assert_nil(updated_change_request.change_set[@entity_type][id].keys.first)
            assert_nil(updated_entity['previous_snapshot_id'])
            updated_entity
          end

          def remove_entity_invalid_change_request(id, remove_params)
            post "/api/#{@entity_path}/#{id}/remove", remove_params
            assert_equal(400, last_response.status)
            assert_equal(
              "{\"error\":\"Invalid change request\"}",
              last_response.body
            )
          end

          def remove_entity_valid_creates_new_entity(id, remove_params)
            post "/api/#{@entity_path}/#{id}/remove", remove_params
            change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(remove_params['change_request_id'])
            updated_entity = JSON.parse(last_response.body)
            assert_equal(201, last_response.status)
            assert_equal(true, updated_entity['is_removed'])
            assert_equal(id, updated_entity['id'])
            assert_includes(change_request.change_set[@entity_type].keys, id)
            assert_equal(change_request.change_set[@entity_type][id].values.first, updated_entity['snapshot_id'])
            assert_equal(change_request.change_set[@entity_type][id].keys.first, updated_entity['previous_snapshot_id'])
            updated_entity
          end

          def remove_entity_valid_updates_existing_snapshot_of_updated_entity(id, remove_params)
            old_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(remove_params['change_request_id'])
            post "/api/#{@entity_path}/#{id}/remove", remove_params
            updated_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(remove_params['change_request_id'])
            updated_entity = JSON.parse(last_response.body)
            assert_equal(201, last_response.status)
            assert_equal(true, updated_entity['is_removed'])
            assert_equal(id, updated_entity['id'])
            assert_includes(updated_change_request.change_set[@entity_type].keys, id)
            assert_equal(updated_change_request.change_set[@entity_type][id].values.first, 
              old_change_request.change_set[@entity_type][id].values.first)
            assert_equal(updated_change_request.change_set[@entity_type][id].keys.first, 
              old_change_request.change_set[@entity_type][id].keys.first)
            updated_entity
          end

          def remove_entity_valid_updates_existing_snapshot_of_new_entity(id, remove_params)
            old_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(remove_params['change_request_id'])
            post "/api/#{@entity_path}/#{id}/remove", remove_params
            updated_change_request = Skee::App::DB_MAPPING_ENTITY[:change_request].find(remove_params['change_request_id'])
            updated_entity = JSON.parse(last_response.body)
            assert_equal(201, last_response.status)
            assert_equal(true, updated_entity['is_removed'])
            assert_equal(id, updated_entity['id'])
            assert_includes(updated_change_request.change_set[@entity_type].keys, id)
            assert_equal(old_change_request.change_set[@entity_type][id].values.first,
              updated_change_request.change_set[@entity_type][id].values.first)
            assert_nil(updated_change_request.change_set[@entity_type][id].keys.first)
            assert_nil(updated_entity['previous_snapshot_id'])
            updated_entity
          end
        end
      end
    end
  end
end