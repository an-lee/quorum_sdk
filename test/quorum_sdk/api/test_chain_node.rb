# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestChain < Minitest::Test
      def setup
        @api = QuorumSdk::API.new SEED_URL
      end

      def test_get_trx
        trx_id = '187b74f4-6a2c-4d7a-ac8d-29f41b90e798'
        r = @api.trx trx_id
        refute_nil r.body
      end
    end
  end
end
