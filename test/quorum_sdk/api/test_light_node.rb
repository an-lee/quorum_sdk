# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestLightNode < Minitest::Test
      def setup
        @api = QuorumSdk::API.new SEED_URL
      end

      def test_send_trx
        key = Eth::Key.new
        data = Quorum::Pb::Object.new(
          type: 'Note',
          name: 'name',
          content: 'content'
        )
        trx = @api.build_trx(data:, private_key: key.private_hex)
        r = @api.send_trx trx
        refute_nil r['trx_id']
      end

      def test_list_trx
        r = @api.list_trx
        assert_instance_of Array, r
      end
    end
  end
end
