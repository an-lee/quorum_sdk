# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestLightNode < Minitest::Test
      def setup
        @api = QuorumSdk::API.new ''
      end

      def test_send_trx
        # TODO: test send trx
      end
    end
  end
end
