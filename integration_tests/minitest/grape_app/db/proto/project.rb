# typed: strict
require_relative './common/doc'
module Skee
  module DB
    module Proto
      class Project < Proto::Common::Doc
        @all_docs = T.let([
          OpenStruct.new(
            id: 'proj123',
            name: 'project 1 lah',
            description: 'project desc 1 leh'
          ),
          OpenStruct.new(
            id: 'proj456',
            name: 'project 2 lah',
            description: 'project desc 2 leh'
          )
        ], T::Array[OpenStruct])
      end
    end
  end
end