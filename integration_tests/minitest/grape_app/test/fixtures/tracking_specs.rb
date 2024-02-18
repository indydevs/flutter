# typed: true
module Skee
  module Test
    module Fixtures
      class TrackingSpecs
        def self.all
          [
            {
              'id': '1',
              'identifier': 'Solarbreeze',
              'version': 'v1',
              'project_id': '1',
              'change_request_id': '1',
              'prev_tracking_spec_id': nil,
              'status': 'current',
              'events': ['1', '3', '4'],
            }
          ]
        end
      end
    end
  end
end