# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    # These tests depend on RUM server config in /config.json
    class TestLightNode < Minitest::Test
      def setup
        @api = QuorumSdk::API.new(seed_url: HTTP_SEED_URL['seed_url']) if HTTP_SEED_URL.present?
      end

      def test_send_trx
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        account = QuorumSdk::Account.new
        data = Quorum::Pb::Object.new(
          type: 'Note',
          name: 'name',
          content: 'content'
        )
        trx = @api.build_trx(data:, private_key: account.private_hex)
        r = @api.send_trx trx
        refute_nil r['trx_id']
      end

      def test_list_trx
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.list_trx reverse: true
        assert_instance_of Array, r
      end

      def test_send_activity_type_trx
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        account = QuorumSdk::Account.new
        article = Quorum::Pb::Object.new(
          type: 'Article',
          name: 'title',
          content: 'article content'
        )
        activity = Quorum::Pb::Activity.new(
          type: 'Create',
          object: article
        )
        trx = @api.build_trx(data: activity, private_key: account.private_hex)
        r = @api.send_trx trx
        refute_nil r['trx_id']
      end

      def test_chain_data_group_info
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.group_info
        refute_nil r
      end

      def test_chain_data_auth_type
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.auth_type('Post')
        puts r
        refute_nil r
      end
    end
  end
end
