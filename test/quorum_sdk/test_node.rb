# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestNode < Minitest::Test
    def test_node_may_initialize
      refute_nil QuorumSdk::Node.new seed: SEED
    end
  end
end
