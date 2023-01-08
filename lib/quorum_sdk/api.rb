# frozen_string_literal: true

require_relative 'api/chain'
require_relative 'api/group'
require_relative 'api/light_node'
require_relative 'api/management'
require_relative 'client'

module QuorumSdk
  # Wrapper for HTTP APIs
  class API
    attr_reader :group_id, :group_name, :consensus_type, :encryption_type, :app_key, :owner_pubkey, :signature,
                :cipher_key, :chain_urls, :client

    def initialize(**kwargs)
      config =
        if kwargs[:seed_url].present?
          QuorumSdk::Utils.parse_seed_url kwargs[:seed_url]
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
      @chain_urls = config[:chain_urls]

      @client = QuorumSdk::Client.new(@chain_urls)
    end

    include QuorumSdk::API::Chain
    include QuorumSdk::API::Group
    include QuorumSdk::API::LightNode
    include QuorumSdk::API::Management
  end
end
