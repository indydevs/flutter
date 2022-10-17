# typed: true
require_relative '../../app/change_request/service'
module Skee
  module App
    module VersionedEntity
      class Entity
        def initialize(entity)
          @entity = entity
          @db = Skee::App::DB_MAPPING_ENTITY[@entity]
        end

        attr_accessor :versioned_entity, :versioned_entity_snapshot

        def list(ids:, change_request_id:)
          ids = @db.all.map(&:id) if ids.empty?
          return_entities = ids.map{ |id| get({
            id: id,
            change_request_id: change_request_id
            })
          }
        end

        def get(params)
          versioned_entity_id = params[:id]
          versioned_entity = @db.find(versioned_entity_id)
          if change_request = Skee::App::ChangeRequest::Service.get(id: params[:change_request_id])
            if change_request.change_set[@entity][versioned_entity_id]
              entity_snapshot_id = change_request.change_set[@entity][versioned_entity_id].values.first
            else
              entity_snapshot_id = versioned_entity.latest_snapshot_id
            end
          else
            entity_snapshot_id = versioned_entity.latest_snapshot_id
          end
          entity_snapshot = Skee::App::VersionedEntitySnapshot::Entity.new(@entity).get(id: entity_snapshot_id)
          self.versioned_entity = versioned_entity
          self.versioned_entity_snapshot = entity_snapshot
          self
        end

        def create(params)
          versioned_entity_params = {
            # may need to add more fields
            # snapshot_mapping: {params[:change_request_id] => entity_snapshot.id
          }
          versioned_entity = @db.create(versioned_entity_params)
          entity_snapshot_params = params.merge(parent_entity_id: versioned_entity.id)
          entity_snapshot = Skee::App::VersionedEntitySnapshot::Entity.new(@entity).create(entity_snapshot_params)
          update_change_request(params[:change_request_id], versioned_entity.id, nil, entity_snapshot.id)
          self.versioned_entity = versioned_entity
          self.versioned_entity_snapshot = entity_snapshot
          self
        end

        def update(update_params)
          versioned_entity_id = update_params[:id]
          change_request = Skee::App::ChangeRequest::Service.get(id: update_params[:change_request_id])
          change_request.change_set[@entity] ||= {}
          entity_snapshot = if change_request.change_set[@entity][versioned_entity_id]
            update_existing_snapshot(change_request, update_params) 
          else
            create_new_snapshot(update_params)
          end
          versioned_entity = @db.find(versioned_entity_id)
          self.versioned_entity = versioned_entity
          self.versioned_entity_snapshot = entity_snapshot
          self
        end

        private

        def update_existing_snapshot(change_request, update_params)
          versioned_entity_id = update_params[:id]
          entity_snapshot_id = change_request.change_set[@entity][versioned_entity_id].values.first
          existing_entity_snapshot = Skee::App::VersionedEntitySnapshot::Entity.new(@entity).get(id: entity_snapshot_id)
          update_params = update_params.select {|key, _| key != :id && key != "id"}
          existing_entity_snapshot.update(update_params)
        end

        def create_new_snapshot(update_params)
          versioned_entity_id = update_params[:id]
          existing_entity = @db.find(versioned_entity_id)
          entity_snapshot_id = existing_entity.latest_snapshot_id
          current_entity_snapshot = Skee::App::VersionedEntitySnapshot::Entity.new(@entity).get(id: entity_snapshot_id)
          current_entity_snapshot_params = current_entity_snapshot.to_h.select {|key, _| key != :id && key != "id"}
          new_entity_snapshot_params = current_entity_snapshot_params.each do |key, _|
            current_entity_snapshot_params[key] = update_params[key] if update_params.key?(key)
          end
          new_entity_snapshot_params[:previous_snapshot_id] = entity_snapshot_id
          new_entity_snapshot_params[:is_removed] = true if update_params[:is_removed]
          new_entity_snapshot = Skee::App::VersionedEntitySnapshot::Entity.new(@entity).create(new_entity_snapshot_params)
          update_change_request(update_params[:change_request_id], versioned_entity_id, entity_snapshot_id, new_entity_snapshot.id)
          new_entity_snapshot
        end

        def update_change_request(change_request_id, versioned_entity_id, current_entity_snapshot_id, new_entity_snapshot_id)
          Skee::App::ChangeRequest::Service.update_change_set(
            id: change_request_id,
            changes: {
              @entity => {
                versioned_entity_id => {
                  current_entity_snapshot_id => new_entity_snapshot_id
                }
              }
            }
          )
        end
      end
    end
  end
end