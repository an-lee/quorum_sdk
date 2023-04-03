# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Chain
    # These tests depend on RUM server config in /config.json
    class TestNode < Minitest::Test
      def setup
        return if HTTP_SEED.blank?

        @chain = QuorumSdk::Chain.new(
          chain_url: HTTP_SEED['chain_url'],
          jwt: HTTP_SEED['jwt']
        )
      end

      def test_get_network
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @chain.network
        refute_nil r['addrs']
      end

      def test_get_node
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @chain.node
        refute_nil r['node_id']
      end
    end
  end
end
