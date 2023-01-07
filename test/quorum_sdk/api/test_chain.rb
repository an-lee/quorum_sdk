# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestChain < Minitest::Test
      def setup
        seed = QuorumSdk::Utils.parse_seed_url(HTTP_SEED_URL['seed_url']) if HTTP_SEED_URL.present?
        return if seed.blank?

        @api = QuorumSdk::API.new(
          group_id: seed[:group_id],
          chain_urls: seed[:chain_urls]
        )
      end

      def test_get_trx
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        trx_id = 'f554400c-06ac-43f0-a8a6-26e5391f044d'
        r = @api.trx trx_id
        refute_nil r
      end
    end
  end
end
