# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    # These tests depend on RUM server config in /config.json
    class TestLightNode < Minitest::Test
      def setup
        @api = QuorumSdk::API.new(seed: HTTP_SEED['seed']) if HTTP_SEED.present?
      end

      def test_send_trx
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        account = QuorumSdk::Account.new
        id = SecureRandom.uuid
        data = {
          type: 'Note',
          id:,
          name: "A random name #{id}",
          content: "A random content #{id}"
        }
        trx = @api.build_trx(trx_id: id, data:, private_key: account.private_hex)
        r = @api.send_trx trx
        assert_equal id, r['trx_id']
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
        article = {
          type: 'Article',
          name: 'title',
          content: 'article content'
        }
        activity = {
          type: 'Create',
          object: article
        }
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
    end
  end
end
