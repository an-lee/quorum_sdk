# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestClient < Minitest::Test
    def test_client_may_initialize
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      refute_nil QuorumSdk::Client.new seed[:chain_urls]
    end
  end
end
