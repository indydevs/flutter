# typed: true
require_relative '../../db/proto/tracking_spec'
module Skee
  module App
    module TrackingSpec
      class Service
        DB = Skee::DB::Proto

        def self.list
          DB::TrackingSpec.all
        end

        def self.get(params)
          DB::TrackingSpec.find(params[:id])
        end

        def self.find_by(params)
          DB::TrackingSpec.where(params)
        end

        def self.create(params)
          # add any validation or filtering logic here to
          # derive fields from params
          fields = {
            version_identifier: params[:version_identifier],
            change_request_id: params[:change_request_id],
            project_id: params[:project_id],
            event_ids: params[:event_ids]
          }
          DB::TrackingSpec.create(fields)
        end

        def self.update(params)
          # send valid fields excluding id
          fields = {
            version_identifier: params[:version_identifier],
            change_request_id: params[:change_request_id],
            project_id: params[:project_id],
            event_ids: params[:event_ids]
          }
          tracking_spec = DB::TrackingSpec.find(params[:id])
          tracking_spec.update(fields)
        end

        def self.delete(params)
          tracking_spec = DB::TrackingSpec.find(params[:id])
          tracking_spec.delete
        end
      end
    end
  end
end
