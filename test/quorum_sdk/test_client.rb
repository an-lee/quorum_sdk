# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestClient < Minitest::Test
    def test_client_may_initialize
      refute_nil QuorumSdk::Client.new SEED_URL
    end
  end
end
