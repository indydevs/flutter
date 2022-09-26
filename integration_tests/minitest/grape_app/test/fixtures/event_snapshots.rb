module Skee
  module Test
    module Fixtures
      class EventSnapshots
        def self.all
          [
            {
              'id': '1',
              'name': 'Closed App',
              'description': 'Description of event A.',
              'payload': {
                'primary_user' => {
                  'reference_entity_type': :trackable_object,
                  'reference_entity_id': '1',
                  'is_array': false,
                  'is_primary': true,
                  'selected_property_ids': ['1'],
                },
                'created_timestamp' => {
                  'reference_entity_type': :property,
                  'reference_entity_id': '2',
                  'is_array': false,
                  'is_primary': nil,
                  'selected_property_ids': ['2'],
                },
                'cart' => {
                  'reference_entity_type': :trackable_object,
                  'reference_entity_id': '3',
                  'is_array': false,
                  'is_primary': nil,
                  'selected_property_ids': ['3'],
                }
              },
              'change_request_id': '1',
              'previous_snapshot_id': nil,
              'is_removed': nil,
            },
            {
              'id': '4',
              'name': 'Launched App',
              'description': 'Description of event A.',
              'payload': {
                'primary_user' => {
                  'reference_entity_type': :trackable_object,
                  'reference_entity_id': '1',
                  'is_array': false,
                  'is_primary': true,
                  'selected_property_ids': ['1'],
                },
                'created_timestamp' => {
                  'reference_entity_type': :property,
                  'reference_entity_id': '2',
                  'is_array': false,
                  'is_primary': nil,
                  'selected_property_ids': ['2'],
                },
                'cart' => {
                  'reference_entity_type': :trackable_object,
                  'reference_entity_id': '3',
                  'is_array': false,
                  'is_primary': nil,
                  'selected_property_ids': ['3'],
                }
              },
              'change_request_id': '1',
              'previous_snapshot_id': nil,
              'is_removed': nil,
            },
            {
              'id': '5',
              'name': 'Opened App',
              'description': 'Description of event A.',
              'payload': {
                'primary_user' => {
                  'reference_entity_type': :trackable_object,
                  'reference_entity_id': '1',
                  'is_array': false,
                  'is_primary': true,
                  'selected_property_ids': ['1'],
                },
                'created_timestamp' => {
                  'reference_entity_type': :property,
                  'reference_entity_id': '2',
                  'is_array': false,
                  'is_primary': nil,
                  'selected_property_ids': ['2'],
                },
                'cart' => {
                  'reference_entity_type': :trackable_object,
                  'reference_entity_id': '3',
                  'is_array': false,
                  'is_primary': nil,
                  'selected_property_ids': ['3'],
                }
              },
              'change_request_id': '1',
              'previous_snapshot_id': nil,
              'is_removed': nil,
            },
          ]
        end
      end
    end
  end
end