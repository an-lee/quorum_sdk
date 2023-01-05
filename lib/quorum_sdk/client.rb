# frozen_string_literal: true

require_relative 'api/light_node'

module QuorumSdk
  # HTTP Client wrapper
  class Client
    attr_reader :domains

    def initialize(domains)
      @domains = domains || []
    end

    def post
      # TODO: http post
    end

    def get
      # TODO: http get
    end

    private

    def request
      # TODO: http request
    end
  end
end
