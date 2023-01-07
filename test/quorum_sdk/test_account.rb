# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestAccount < Minitest::Test
    def test_account_may_initialize
      key = Eth::Key.new
      account = QuorumSdk::Account.new priv: key.private_hex

      assert_instance_of QuorumSdk::Account, account
      assert_equal key.address.to_s, account.address.to_s
    end
  end
end
