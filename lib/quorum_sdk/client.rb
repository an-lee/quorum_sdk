# frozen_string_literal: true

module QuorumSdk
  # HTTP Client wrapper
  class Client
    attr_reader :domains

    def initialize(chain_url, jwt = nil)
      chain_url =
        case chain_url
        when Array
          chain_url.first
        when String
          chain_url
        end

      uri = Addressable::URI.parse chain_url
      url = Addressable::URI.new(scheme: uri.scheme, host: uri.host, port: uri.port).to_s
      jwt ||= uri.query_values['jwt']

      @conn =
        Faraday.new(
          url:,
          headers: { Authorization: "Bearer #{jwt}" }
        ) do |f|
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
