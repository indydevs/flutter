require_relative '../../test_helper'
module Skee
  module API
    module Test
      module Functional
        class TrackingSpecTest < MiniTest::Test
          include Rack::Test::Methods

          def app
            Skee::API::Routes::TrackingSpec::API
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
          end

          def test_expands_results
            change_request_id = '0'
            tracking_spec_id = '1'
            params = {'change_request_id' => change_request_id}
            get "/api/tracking_specs/#{tracking_spec_id}/expand", params
            assert last_response.ok?
          end
        end
      end
    end
  end
end