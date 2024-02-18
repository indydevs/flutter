# typed: true
require_relative '../../db/proto/change_request'
module Skee
  module App
    module ChangeRequest
      class Service
        DB = Skee::DB::Proto

        def self.list
          DB::ChangeRequest.all
        end

        def self.get(params)
          DB::ChangeRequest.find(params[:id])
        end

        def self.create(params)
          # add any validation or filtering logic here to
          # derive fields from params
          fields = {
            identifier: params[:identifier],
            project_id: params[:project_id],
            base_tracking_spec_id: params[:base_tracking_spec_id],
            status: params[:status],
            name: params[:name],
            description: params[:description],
            change_set: params[:change_set]
          }
          DB::ChangeRequest.create(fields)
        end

        def self.update(params)
          # send valid fields excluding id
          fields = {
            identifier: params[:identifier],
            project_id: params[:project_id],
            base_tracking_spec_id: params[:base_tracking_spec_id],
            status: params[:status],
            name: params[:name],
            description: params[:description],
            change_set: params[:change_set]
          }.compact
          change_request = DB::ChangeRequest.find(params[:id])
          change_request.update(fields)
        end

        def self.update_change_set(params)
          change_request = DB::ChangeRequest.find(params[:id])
          existing_change_set = change_request.change_set
          params[:changes].each do |entity, change_hash|
            existing_change_set[entity] ||= {}
            change_hash.each do |prev_id, new_id|
              if prev_id
                existing_change_set[entity][prev_id] = new_id
              else
                existing_change_set[entity][nil] ||= []
                existing_change_set[entity][nil] << new_id
              end
            end
          end
        end

        def self.remove_from_change_set(id:, entity:, entity_id:)
          change_request = DB::ChangeRequest.find(id)
          existing_change_set = change_request.change_set
          if existing_change_set[entity].values.include?(entity_id)
            existing_change_set[entity].delete_if {|_,value| value == entity_id}
          elsif existing_change_set[entity][nil].include?(entity_id)
            existing_change_set[entity][nil].delete(entity_id)
          end
        end

        def self.delete(params)
          change_request = DB::ChangeRequest.find(params[:id])
          change_request.delete
        end
      end
    end
  end
end