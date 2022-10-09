# typed: true
module Skee
  module Test
    module Fixtures
      class TrackableObjectSnapshots
        def self.all
          [{
             'id': '1',
             'name': 'User',
             'change_request_id': '16',
             'previous_snapshot_id': nil,
             'property_ids': ['1'],
             'is_removed': nil,
           }, {
             'id': '2',
             'name': 'Product',
             'change_request_id': '12',
             'previous_snapshot_id': nil,
             'property_ids': ['4'],
             'is_removed': nil,
           }, {
             'id': '3',
             'name': 'Cart',
             'change_request_id': '16',
             'previous_snapshot_id': '15',
             'property_ids': ['3'],
             'is_removed': nil,
           }, {
             'id': '4',
             'name': 'Shop',
             'change_request_id': '14',
             'previous_snapshot_id': '15',
             'property_ids': [],
             'is_removed': nil,
           }, {
             'id': '5',
             'name': 'Shops',
             'change_request_id': '18',
             'previous_snapshot_id': '4',
             'property_ids': [],
             'is_removed': nil,
           }, {
             'id': '6',
             'name': 'Store',
             'change_request_id': '18',
             'previous_snapshot_id': nil,
             'property_ids': ['7', '8'],
             'is_removed': nil,
           }, {
             'id': '7',
             'name': 'Signed-in User',
             'change_request_id': '1',
             'previous_snapshot_id': nil,
             'property_ids': ['1'],
             'is_removed': nil,
           }
          ]
        end
      end
    end
  end
end