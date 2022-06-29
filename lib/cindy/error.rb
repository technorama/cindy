module Cindy
  # Generic error
  class Error < StandardError; end

  class NoDataPasssed < Error; end

  class APIKeyNotPassed < Error; end

  class InvalidAPIKey < Error; end

  class EmailNotPassed < Error; end

  class ListIDNotPassed < Error; end

  class ListDoesNotExist < Error; end

  class EmailDoesNotExistInList < Error; end

  class SomeFieldsAreMissing < Error; end

  class InvalidEmailAddress < Error; end

  class InvalidCountry < Error; end

  class AlreadySubscribed < Error; end

  class SubscriberDoesNotExist < Error; end

  class BouncedEmailAddress < Error; end

  class EmailIsSuppressed < Error; end

  # Raised when Sendy returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when Sendy returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Sendy returns a 403 HTTP status code
  class Forbidden < Error; end

  # Raised when Sendy returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when Sendy returns a 406 HTTP status code
  class NotAcceptable < Error; end

  # Raised when Sendy returns a 422 HTTP status code
  class UnprocessableEntity < Error; end

  # Raised when Sendy returns a 500 HTTP status code
  class InternalServerError < Error; end

  # Raised when Sendy returns a 501 HTTP status code
  class NotImplemented < Error; end

  # Raised when Sendy returns a temporary error (502/503/504 HTTP status code)
  class TransientError < Error; end
end
