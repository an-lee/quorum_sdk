# frozen_string_literal: true

require_relative 'client'
require_relative 'light_node/node'

module QuorumSdk
  # Wrapper for HTTP APIs as light node client
  class LightNode
    attr_reader :group_id, :group_name, :consensus_type, :encryption_type, :app_key, :owner_pubkey, :signature,
                :cipher_key, :chain_url, :jwt, :client

    def initialize(**kwargs)
      config =
        if kwargs[:seed].present?
          QuorumSdk::Utils.parse_seed kwargs[:seed]
        else
          kwargs
        end

      @group_id = config[:group_id]
      @group_name = config[:group_name]
      @consensus_type = config[:consensus_type]
      @encryption_type = config[:encryption_type]
      @app_key = config[:app_key]
      @owner_pubkey = config[:owner_pubkey]
      @signature = config[:signature]
      @cipher_key = config[:cipher_key]
      @chain_url = config[:chain_url]
      @jwt = config[:jwt]

      @client = QuorumSdk::Client.new(@chain_url, @jwt)
    end

    include QuorumSdk::LightNode::Node
  end
end