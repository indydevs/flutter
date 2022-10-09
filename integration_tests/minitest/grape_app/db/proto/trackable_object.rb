# typed: strict
require_relative './common/doc'
module Skee
  module DB
    module Proto
      class TrackableObject < Proto::Common::Doc
        @all_docs = []
      end
    end
  end
end