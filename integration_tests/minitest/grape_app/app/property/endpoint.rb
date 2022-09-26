require_relative './service'
module Skee::App::Property
  class Endpoint

    ERRORS = Skee::App::Utils::Errors

    def self.list
      Service.list
    end

    def self.get(params)
      Service.get(params)
    end

    def self.create(params)
      Service.create(params)
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.update(params)
      Service.update(params)
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.remove(params)
      Service.remove(params)
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end
  end
end