# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Chain
    # These tests depend on RUM server config in /config.json
    class TestChain < Minitest::Test
      def setup
        return if HTTP_SEED.blank?

        @node = QuorumSdk::FullNode.new(
          chain_url: HTTP_SEED['chain_url'],
          jwt: HTTP_SEED['jwt']
        )
      end

      def test_get_trx
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        trx_id = 'f554400c-06ac-43f0-a8a6-26e5391f044d'
        r = @node.trx trx_id, group_id: ''
        refute_nil r
      end
    end
  end
end
