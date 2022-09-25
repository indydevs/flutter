require_relative './service'
module Skee::App::Event
  class Endpoint

    ERRORS = Skee::App::Utils::Errors

    def self.list
      Service.list
    end

    def self.get(params)
      Service.get(params)
    end

    def self.create(params)
      Service.create(formatted_params(params))
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.update(params)
      Service.update(formatted_params(params))
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.update_payload_keys(params)
      Service.update_payload_keys(formatted_params(params))
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.remove_payload_keys(params)
      Service.remove_payload_keys(formatted_params(params))
    rescue ERRORS::RecordNotFoundException,
      ERRORS::NotAllowedToUpdate,
      ERRORS::UniquenessViolationException => e
      raise ERRORS::ValidationError.new(e.message)
    end

    def self.add_payload_keys(params)
      Service.add_payload_keys(formatted_params(params))
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

    private

    def self.formatted_params(params)
      existing_payload = params[:payload]
      return params unless existing_payload

      new_payload = existing_payload.map do |payload|
        key = payload[:key]
        payload.delete(:key)
        [key, payload]
      end.to_h
      params[:payload] = new_payload
      params
    end
  end
end