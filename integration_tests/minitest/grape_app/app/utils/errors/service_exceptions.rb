# typed: strict
module Skee
  module App
    module Utils
      module Errors
        class UniquenessViolationException < StandardError; end
        class RecordNotFoundException < StandardError; end
        class NotAllowedToUpdate < StandardError; end
        class NotAllowedToCancelChanges < StandardError; end
      end
    end
  end
end