# frozen_string_literal: true

require_relative 'api/light_node'

module QuorumSdk
  # HTTP Client wrapper
  class Client
    attr_reader :domains

    def initialize(domains)
      @domains = domains || []
      uri = Addressable::URI.parse @domains.first
      url = Addressable::URI.new(scheme: uri.scheme, host: uri.host, port: uri.port).to_s
      jwt = uri.query_values['jwt']

      @conn = Faraday.new(url:, headers: { Authorization: "Bearer #{jwt}" }) do |f|
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
