module Skee
  module API
    module Routes
      module Project
        class ResponseEntity < Grape::Entity
          expose :id, documentation: { type: 'String', desc: 'Unique ID of a project.' }
          expose :name, documentation: { type: 'String', desc: 'Name of the project.' }
          expose :description, documentation: { type: 'String', desc: 'Description of the project.' }
        end
      end
    end
  end
end