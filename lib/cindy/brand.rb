# frozen_string_literal: true

module Cindy
  class Brand
    attr_reader :id

    def initialize(connection, id)
      @connection = connection
      @id = id
    end

    def lists(include_hidden: false)
      response = connection.post "api/lists/get-lists.php" do |req|
        req.body = {brand_id: brand_id, include_hidden: include_hidden, api_key: @key}
      end

      response.body
    end
  end
end
