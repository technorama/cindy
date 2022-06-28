# frozen_string_literal: true

module Cindy
  class List
    attr_reader :id

    def initialize(cindy, list_id)
      @cindy = cindy
      @id = list_id
    end

    def subscribe!(email, name = nil, custom_params = {})
      @cindy.subscribe @id, email, name, custom_params
    end

    def subscribe(email, name = nil, custom_params = {})
      @cindy.subscribe @id, email, name, custom_params
    end

    def unsubscribe(email)
      @cindy.unsubscribe @id, email
    end

    def subscriber_delete(email)
      @cindy.delete_subscriber @id, email
    end

    def subscriber_status(email)
      @cindy.subscription_status @id, email
    end

    def active_subscriber_count
      @cindy.active_subscriber_count @id
    end
  end
end
