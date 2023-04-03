# frozen_string_literal: true

require_relative 'chain/chain'
require_relative 'chain/group'
require_relative 'chain/management'
require_relative 'chain/node'
require_relative 'client'

module QuorumSdk
  # Wrapper for HTTP APIs as chain admin
  class Chain
    attr_reader :chain_url, :jwt, :client

    def initialize(**kwargs)
      @chain_url = kwargs[:chain_url]
      @jwt = kwargs[:jwt]

      @client = QuorumSdk::Client.new(@chain_url, @jwt)
    end

    include QuorumSdk::Chain::Chain
    include QuorumSdk::Chain::Group
    include QuorumSdk::Chain::Management
    include QuorumSdk::Chain::Node
  end
end
