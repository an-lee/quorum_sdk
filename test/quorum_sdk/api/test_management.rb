# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestManagement < Minitest::Test
      def setup
        seed = QuorumSdk::Utils.parse_seed_url(HTTP_SEED_URL['seed_url']) if HTTP_SEED_URL.present?
        return if seed.blank?

        @api = QuorumSdk::API.new(
          group_id: seed[:group_id],
          chain_urls: seed[:chain_urls]
        )
      end

      def test_allow_list
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.allow_list
        refute_nil r
      end

      def test_deny_list
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.deny_list
        refute_nil r
      end

      def test_auth_type
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.auth_type('POST')
        refute_nil r['AuthType']
      end

      def test_update_auth_type
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.update_trx_auth_mode(trx_auth_mode: 'follow_alw_list')
        refute_nil r['trx_id']
      end

      def test_update_allow_list
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        key = QuorumSdk::Account.new
        r = @api.update_allow_list(action: 'add', pubkey: key.public_hex)
        refute_nil r['trx_id']
      end

      def test_update_deny_list
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        key = QuorumSdk::Account.new
        r = @api.update_deny_list(action: 'add', pubkey: key.public_hex)
        refute_nil r
      end
    end
  end
end
