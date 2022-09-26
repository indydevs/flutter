require_relative '../../app/change_request/service'
module Skee
  module App
    module VersionedEntitySnapshot
      class Entity
        def initialize(entity)
          @entity = entity
          @db = Skee::App::DB_MAPPING_ENTITY_SNAPSHOT[@entity]
        end

        def list(ids:)
          return @db.all if ids.empty?
          @db.find_all(ids: ids)
        end

        def get(params)
          # add validator, to reject if nil, or does not exist.
          @db.find(params[:id])
        end

        def create(params)
          @db.create(params)
        end

        def update(update_params)
          snapshot = @db.find(update_params[:id])
          snapshot.update(update_params)
        end
      end
    end
  end
end