# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestChain < Minitest::Test
      def setup
        @api = QuorumSdk::API.new(HTTP_SEED_URL['seed_url']) if HTTP_SEED_URL.present?
      end

      def test_get_trx
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        trx_id = '187b74f4-6a2c-4d7a-ac8d-29f41b90e798'
        r = @api.trx trx_id
        refute_nil r
      end
    end
  end
end
