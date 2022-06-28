# frozen_string_literal: true

require 'faraday'
require 'faraday/mashify'
require 'faraday/follow_redirects'
require 'faraday/response/raise_cindy_error'

module Cindy
  class Client
    def initialize(sendy_url, api_key = nil)
      @url = sendy_url
      @key = api_key || ENV['SENDY_API_KEY']
    end

    def create_campaign(opts={})
      post_opts     = {}
      req_opts      = %i(from_name from_email reply_to subject html_text)
      optional_opts = %i(plain_text list_ids brand_id send_campaign query_string title)

      req_opts.each do |opt|
        post_opts[opt] = opts.delete(opt) || raise(ArgumentError, "opt :#{opt} required")
      end
      post_opts.merge!(Hash[optional_opts.zip(opts.values_at(*optional_opts))])
      post_opts[:api_key] = @key

      response = connection.post "api/campaigns/create.php" do |req|
        req.body = post_opts
      end

      response.body
    end

    def subscribe(list_id, email, name = nil, custom_params = {})
      response = connection.post "subscribe" do |req|
        opts = {list: list_id, email: email, boolean: true}
        opts[:name] = name if name
        params = opts.merge(custom_params)
        req.body = params
      end

      !!(response.body =~ /^1$/)
    end

    def unsubscribe(list_id, email)
      response = connection.post "unsubscribe", {list: list_id, email: email, boolean: true}

      !!(response.body =~ /^1$/)
    end

    def delete_subscriber(list_id, email)
      response = connection.post "api/subscribers/delete.php" do |req|
        req.body = {list_id: list_id, email: email, api_key: @key}
      end

      !!(response.body =~ /^1$/)
    end

    def subscription_status(list_id, email)
      response = connection.post "api/subscribers/subscription-status.php" do |req|
        req.body = {list_id: list_id, email: email, api_key: @key}
      end

      response.body
    end

    def active_subscriber_count(list_id)
      response = connection.post "api/subscribers/active-subscriber-count.php" do |req|
        req.body = {list_id: list_id, api_key: @key}
      end

      response.body.to_i
    end

    def brand(brand_id)
      Brand.new connection, brand_id
    end

    def list(list_id)
      List.new self, list_id
    end

    def brands
      response = connection.post "api/brands/get-brands.php" do |req|
        req.body = {api_key: @key}
      end

      # TODO: Implement .brands
      raise NotImplementedError.new("Implement .brands returning [Brand, ...]")
    end

    protected

    def connection
      @connection ||= Faraday.new(:url => @url) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter

        faraday.use ::Faraday::Response::RaiseCindyError
        faraday.use ::Faraday::FollowRedirects::Middleware
        faraday.response :mashify
      end
    end

  end
end
