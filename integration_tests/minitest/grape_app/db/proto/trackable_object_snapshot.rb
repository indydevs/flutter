# typed: strict
require_relative './common/doc'
module Skee
  module DB
    module Proto
      class TrackableObjectSnapshot < Proto::Common::Doc
        @all_docs = T.let([], T::Array[T.untyped])
      end
    end
  end
end