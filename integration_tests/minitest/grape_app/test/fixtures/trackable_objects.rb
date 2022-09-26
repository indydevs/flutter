module Skee
  module Test
    module Fixtures
      class TrackableObjects
        def self.all
          [{
             'id': '1',
             'latest_snapshot_id': '1',
             'snapshot_mapping': {
               '0' => '1'
             },
             'is_removed': nil,
           }, {
             'id': '2',
             'latest_snapshot_id': '2',
             'snapshot_mapping': {
               '0' => '2'
             },
             'is_removed': nil,
           }, {
             'id': '3',
             'latest_snapshot_id': '3',
             'snapshot_mapping': {
               '0' => '3'
             },
             'is_removed': nil,
           }, {
             'id': '4',
             'latest_snapshot_id': '4',
             'snapshot_mapping': {
             },
             'is_removed': nil,
           }, {
             'id': '5',
             'latest_snapshot_id': '4',
             'snapshot_mapping': {
             },
             'is_removed': nil,
           }, {
             'id': '6',
             'latest_snapshot_id': '6',
             'snapshot_mapping': {
               '0' => '6'
             },
             'is_removed': nil,
           }, {
             'id': '7',
             'latest_snapshot_id': nil,
             'snapshot_mapping': {
             },
             'is_removed': nil,
           }
          ]
        end
      end
    end
  end
end