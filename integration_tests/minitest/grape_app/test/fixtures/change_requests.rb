# typed: true
module Skee
  module Test
    module Fixtures
      class ChangeRequests
        def self.all
          all_change_requests = [
            {
              'id': '1',
              'name': 'Self-enabling disintermediate budgetary management',
              'identifier': 'Voltsillam',
              'project_id': '1',
              'source_tracking_spec_id': '0',
              'status': 'open',
              'description': 'nulla suscipit ligula in lacus curabitur at ipsum',
              'change_set': {
                trackable_object: {
                  '4' => {
                    '4' => '5'
                  },
                  '5' => {
                    nil => '7'
                  }
                },
                property: {
                  '4' => {
                    '4' => '5'
                  },
                  '5' => {
                    nil => '7'
                  }
                },
                event: {
                  '4' => {
                    '4' => '5'
                  },
                  '5' => {
                    nil => '7'
                  }
                },
              }
            }
          ]
          all_change_requests << initial_change_request
        end

        def self.initial_change_request
          {
            'id': '0',
            'name': 'Budgetary management',
            'identifier': 'beginning',
            'project_id': '1',
            'source_tracking_spec_id': nil,
            'status': 'open',
            'description': 'nulla suscipit ligula in lacus curabitur at ipsum',
            'change_set': {
              trackable_object: {
                '4' => {
                  nil => '4'
                },
              },
              property: {
                '5' => {
                  nil => '7'
                }
              },
              event: {
                '1' => {
                  nil => '1'
                },
                '3' => {
                  nil => '5'
                },
                '4' => {
                  nil => '4'
                }
              },
            }
          }
        end
      end
    end
  end
end