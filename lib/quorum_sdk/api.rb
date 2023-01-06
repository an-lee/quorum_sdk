# frozen_string_literal: true

require_relative 'api/chain'
require_relative 'api/light_node'
require_relative 'client'

module QuorumSdk
  # Wrapper for HTTP APIs
  class API
    attr_reader :group_id, :group_name, :consensus_type, :encryption_type, :app_key, :owner_pubkey, :signature,
                :cipher_key, :chain_urls, :client

    def initialize(seed_url)
      r = QuorumSdk::Utils.parse_seed_url seed_url

      @group_id = r[:group_id]
      @group_name = r[:group_name]
      @consensus_type = r[:consensus_type]
      @encryption_type = r[:encryption_type]
      @app_key = r[:app_key]
      @owner_pubkey = r[:owner_pubkey]
      @signature = r[:signature]
      @cipher_key = r[:cipher_key]
      @chain_urls = r[:chain_urls]

      @client = QuorumSdk::Client.new(@chain_urls)
    end

    include QuorumSdk::API::Chain
    include QuorumSdk::API::LightNode
  end
end
