require 'faraday'
require 'cindy/error'

module Faraday
  class Response::RaiseCindyError < Response::Middleware

    def on_complete(response)
      case response[:body]
      when /No data passed/i
        raise ::Cindy::NoDataPassed
      when /Already subscribed./i
        raise ::Cindy::AlreadySubscribed
      when /Invalid email address./i
        raise ::Cindy::InvalidEmailAddress
      when /Subscriber does not exist./i
        raise ::Cindy::SubscriberDoesNotExist
      end
    end

  end
end
