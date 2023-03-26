# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class FullNode
    # These tests depend on RUM server config in /config.json
    class TestManagement < Minitest::Test
      def setup
        return if HTTP_SEED.blank?

        @node = QuorumSdk::FullNode.new(
          chain_url: HTTP_SEED['chain_url'],
          jwt: HTTP_SEED['jwt']
        )
      end

      def test_allow_list
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.allow_list
        refute_nil r
      end

      def test_deny_list
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.deny_list
        refute_nil r
      end

      def test_auth_type
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.auth_type('POST')
        refute_nil r['AuthType']
      end

      def test_update_auth_type
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.update_trx_auth_mode(trx_auth_mode: 'follow_dny_list')
        refute_nil r['trx_id']
      end

      def test_update_allow_list
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        key = QuorumSdk::Account.new
        r = @node.update_allow_list(action: 'add', pubkey: key.public_hex)
        refute_nil r['trx_id']
      end

      def test_update_deny_list
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        key = QuorumSdk::Account.new
        r = @node.update_deny_list(action: 'add', pubkey: key.public_hex)
        refute_nil r
      end
    end
  end
end
