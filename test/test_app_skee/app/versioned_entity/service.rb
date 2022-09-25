require_relative 'validator'
require_relative 'entity'
require_relative '../versioned_entity_snapshot/entity'
module Skee
  module App
    class VersionedEntityService
      def self.list(ids: [], change_request_id: nil)
        Skee::App::VersionedEntity::Entity.new(entity).list(ids: ids, change_request_id: change_request_id)
      end

      def self.get(params)
        Skee::App::VersionedEntity::Entity.new(entity).get(params)
      end

      def self.create(params)
        Skee::App::VersionedEntity::Validator.new(
          params, entity
        ).validate_create_params
        create_fields = create_fields_keys.map do |key|
          value = key == :prev_entity_id ? nil : params[key]
          [key, value]
        end.to_h
        Skee::App::VersionedEntity::Entity.new(entity).create(create_fields)
      end

      def self.update(params)
        Skee::App::VersionedEntity::Validator.new(
          params, entity
        ).validate_update_params
        update_fields = params.slice(*update_fields_keys).compact
        Skee::App::VersionedEntity::Entity.new(entity).update(update_fields)
      end

      def self.remove(params)
        Skee::App::VersionedEntity::Validator.new(
          params, entity
        ).validate_remove_params
        remove_fields = {
          change_request_id: params[:change_request_id],
          id: params[:id],
          is_removed: true
        }
        Skee::App::VersionedEntity::Entity.new(entity).update(remove_fields)
      end
    end
  end
end