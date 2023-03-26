# frozen_string_literal: true

require_relative 'full_node/chain'
require_relative 'full_node/group'
require_relative 'full_node/management'
require_relative 'client'

module QuorumSdk
  # Wrapper for HTTP APIs as chain admin
  class FullNode
    attr_reader :chain_url, :jwt, :client

    def initialize(**kwargs)
      @chain_url = kwargs[:chain_url]
      @jwt = kwargs[:jwt]

      @client = QuorumSdk::Client.new(@chain_url, @jwt)
    end

    include QuorumSdk::FullNode::Chain
    include QuorumSdk::FullNode::Group
    include QuorumSdk::FullNode::Management
  end
end
