# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestLightNode < Minitest::Test
      def setup
        @api = QuorumSdk::API.new SEED_URL
      end

      def test_send_trx
        object = {
          type: 'Note',
          name: 'Note title',
          content: 'Note body'
        }
        data = QuorumSdk::Utils.encode_object(**object)
        trx = @api.build_trx(data:)
        r = @api.send_trx trx
        refute_nil r.body
      end

      def test_list_trx
        r = @api.list_trx
        p r.body
        refute_nil r.body
      end
    end
  end
end
