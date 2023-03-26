# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestLightNode < Minitest::Test
    def test_light_node_may_initialize
      refute_nil QuorumSdk::LightNode.new seed: SEED
    end
  end
end
