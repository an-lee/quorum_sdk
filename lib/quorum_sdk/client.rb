# frozen_string_literal: true

require_relative 'api/light_node'

module QuorumSdk
  # HTTP Client wrapper
  class Client
    attr_reader :domains

    def initialize(domains)
      @domains = domains || []
      @conn = Faraday.new(url: @domains.first) do |f|
        f.request :json
        f.response :json
        f.response :logger
      end
    end

    def post(path, **body)
      @conn.post path, body.to_json
    end

    def get(path, **params)
      @conn.get path, **params
    end
  end
end
