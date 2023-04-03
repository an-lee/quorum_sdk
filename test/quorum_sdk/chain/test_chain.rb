# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Chain
    # These tests depend on RUM server config in /config.json
    class TestChain < Minitest::Test
      def setup
        return if HTTP_SEED.blank?

        @node = QuorumSdk::Chain.new(
          chain_url: HTTP_SEED['chain_url'],
          jwt: HTTP_SEED['jwt']
        )
      end

      def test_get_trx
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        group_id = 'e5534916-1cfc-428f-8932-dd6344022e29'
        trx_id = 'f554400c-06ac-43f0-a8a6-26e5391f044d'
        r = @node.trx group_id, trx_id
        refute_nil r['TrxId']
      end

      def test_get_block
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        group_id = 'e5534916-1cfc-428f-8932-dd6344022e29'
        trx_id = 'f554400c-06ac-43f0-a8a6-26e5391f044d'
        r = @node.block group_id, trx_id
        refute_nil r['BlockId']
      end
    end
  end
end
