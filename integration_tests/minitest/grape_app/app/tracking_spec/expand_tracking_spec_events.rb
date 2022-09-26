require_relative '../../app/event/service'
require_relative '../../app/property/service'

module Skee::App::TrackingSpec
  class ExpandTrackingSpecEvents
    def initialize(tracking_spec, change_request_id)
      @tracking_spec = tracking_spec
      @change_request_id = change_request_id
    end

    def perform
      expand_events
    end

    private

    def event_snapshots
      @tracking_spec.events.map do |event_id|
        Skee::App::Event::Service.get(
          id: event_id,
          change_request_id: @change_request_id
        ).versioned_entity_snapshot
      end
    end

    def expand_events
      event_snapshots.map do |snapshot|
        event_payload = snapshot.payload
        expanded_payload = event_payload.map do |key, value|
          expanded_value = if value[:reference_entity_type] == :trackable_object
            trackable_object_id = value[:reference_entity_id]
            trackable_object_snapshot = get_trackable_object_snapshot(trackable_object_id)
            property_ids = value[:selected_property_ids] & trackable_object_snapshot.property_ids
            expand_trackable_object_properties(property_ids)
          else
            property_id = value[:reference_entity_id]
            property_snapshot = get_property_snapshot(property_id)
            expand_property(property_snapshot)
          end
          expanded_value = [expanqded_value] if value[:is_array]
          [key, expanded_value]
        end.to_h
        {name: snapshot.name, description: snapshot.description, payload: expanded_payload}
      end
    end

    def expand_trackable_object_properties(property_ids)
      property_ids.map do |property_id|
        property_snapshot = get_property_snapshot(property_id)
        property_fields = expand_property(property_snapshot)

        [property_snapshot.name, property_fields]
      end.to_h

    end

    def expand_property(property_snapshot)
      trackable_object_id = property_snapshot.trackable_object_id
      if trackable_object_id
        trackable_object_snapshot = get_trackable_object_snapshot(trackable_object_id)
        property_ids = trackable_object_snapshot.property_ids
        expanded_values = expand_trackable_object_properties(property_ids)
        property_snapshot.is_array ? [expanded_values] : expanded_values
      else
        {
          data_type: property_snapshot.data_type,
          description: property_snapshot.description,
          is_nullable: property_snapshot.is_nullable,
          additional_instructions: property_snapshot.additional_instructions,
          data_format_id: property_snapshot.data_format_id,
          regex_validation: property_snapshot.regex_validation,
          is_removed: property_snapshot.is_removed,
        }
      end
    end

    def get_trackable_object_snapshot(trackable_object_id)
      Skee::App::TrackableObject::Service.get(
        id: trackable_object_id,
        change_request_id: @change_request_id
      ).versioned_entity_snapshot
    end

    def get_property_snapshot(property_id)
      Skee::App::Property::Service.get(
        id: property_id,
        change_request_id: @change_request_id
      ).versioned_entity_snapshot
    end
  end
end