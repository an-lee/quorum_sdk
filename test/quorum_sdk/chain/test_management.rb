# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Chain
    # These tests depend on RUM server config in /config.json
    class TestManagement < Minitest::Test
      def setup
        return if HTTP_SEED.blank?

        @chain = QuorumSdk::Chain.new(
          chain_url: HTTP_SEED['chain_url'],
          jwt: HTTP_SEED['jwt']
        )

        @group_id = HTTP_SEED['group_id']
      end

      def test_allow_list
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @chain.allow_list @group_id
        refute_nil r
      end

      def test_deny_list
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @chain.deny_list @group_id
        refute_nil r
      end

      def test_auth_mode
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @chain.auth_mode('POST', @group_id)
        refute_nil r['AuthType']
      end

      def test_update_auth_mode
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @chain.update_trx_auth_mode(trx_auth_mode: 'follow_dny_list', group_id: @group_id)
        refute_nil r['trx_id']
      end

      def test_update_allow_list
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        key = QuorumSdk::Account.new
        r = @chain.update_allow_list(action: 'add', pubkey: key.public_hex, group_id: @group_id)
        refute_nil r['trx_id']
      end

      def test_update_deny_list
        if @chain.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        key = QuorumSdk::Account.new
        r = @chain.update_deny_list(action: 'add', pubkey: key.public_hex)
        refute_nil r
      end
    end
  end
end
