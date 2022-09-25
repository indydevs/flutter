require_relative './service'
module Skee::App::ChangeRequest
  class Endpoint
    def self.list
      Service.list
    end

    def self.get(params)
      Service.get(params)
    end

    def self.create(params)
      Service.create(params)
    end

    def self.update(params)
      Service.update(params)
    end

    def self.delete(params)
      Service.delete(params)
    end
  end
end