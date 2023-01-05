# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestAPI < Minitest::Test
    def test_api_may_initialize
      refute_nil QuorumSdk::API.new ''
    end
  end
end
