# frozen_string_literal: true

require_relative 'api/light_node'
require_relative 'client'

module QuorumSdk
  # Wrapper for HTTP APIs
  class API
    attr_reader :group_id, :group_name, :consensus_type, :encryption_type, :app_key, :owner_pubkey, :signature,
                :cipher, :urls, :timestamp

    def initialize(seed_url)
      r = QuorumSdk::Utils.parse_seed_url seed_url

      @group_id = r[:group_id]
      @group_name = r[:group_name]
      @consensus_type = r[:consensus_type]
      @encryption_type = r[:encryption_type]
      @app_key = r[:app_key]
      @owner_pubkey = r[:owner_pubkey]
      @signature = r[:signature]
      @cipher = r[:cipher]
      @urls = r[:urls]
      @timestamp = r[:timestamp]

      @client = QuorumSdk::Client.new(@urls)
    end

    include QuorumSdk::API::LightNode
  end
end
