# typed: false
module Skee
  module API
    module Routes
      module APIHelpers
        def whitelisted_params
          declared(params, include_missing: false)
        end
      end
    end
  end
end

