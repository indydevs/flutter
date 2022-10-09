# typed: true
require_relative '../../db/proto/project'
module Skee
  module App
    module Project
      class Service
        DB = Skee::DB::Proto
    
        def self.list
          DB::Project.all
        end
    
        def self.get(params)
          DB::Project.find(params[:id])
        end
    
        def self.create(params)
          # add any validation or filtering logic here to
          fields = {
            name: params[:name],
            description: params[:description]
          }
          DB::Project.create(fields)
        end
    
        def self.update(params)
          # send valid fields excluding id
          fields = {
            name: params[:name],
            description: params[:description]
          }
          project = DB::Project.find(params[:id])
          project.update(fields)
        end
    
        def self.delete(params)
          project = DB::Project.find(params[:id])
          project.delete
        end
      end
    end
  end
end