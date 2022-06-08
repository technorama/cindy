require 'faraday/middleware'
require 'cindy/error'

module Faraday
  class Response
    class RaiseCindyError < Middleware
      def on_complete(response)
        case status = response.status
        when 200
        when 404
          raise ::Cindy::NotFound.new(response.url)
        else
          raise ::Cindy::Error.new("unknown status #{status}, open a PR")
        end

        case response[:body]
        when /^API key not passed/i
          raise ::Cindy::APIKeyNotPassed
        when /^No data passed/i
          raise ::Cindy::NoDataPassed
        when /^Already subscribed/i
          raise ::Cindy::AlreadySubscribed
        when /^Invalid email address./i
          raise ::Cindy::InvalidEmailAddress
        when /^Subscriber does not exist/i
          raise ::Cindy::SubscriberDoesNotExist
        when /^Email does not exist/i
          raise ::Cindy::EmailDoesNotExistInList
        when /^Bounced email address/i
          raise ::Cindy::BouncedEmailAddress
        when /^Email is suppressed/i
          raise ::Cindy::EmailIsSuppressed
        when /^Country must be a valid 2 letter country code/i
          raise ::Cindy::InvalidCountry
        end
      end
    end
  end
end

