# frozen_string_literal: true

require 'test_helper'

class TestQuorumSdk < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::QuorumSdk::VERSION
  end
end
