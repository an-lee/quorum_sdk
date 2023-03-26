# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class LightNode
    # These tests depend on RUM server config in /config.json
    class TestNode < Minitest::Test
      def setup
        @node = QuorumSdk::LightNode.new(seed: HTTP_SEED['seed']) if HTTP_SEED.present?
      end

      def test_send_trx
        if @node.blank?
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
        trx = @node.build_trx(trx_id: id, data:, private_key: account.private_hex)
        r = @node.send_trx trx
        assert_equal id, r['trx_id']
      end

      def test_list_trx
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.list_trx reverse: true
        assert_instance_of Array, r
      end

      def test_send_activity_type_trx
        if @node.blank?
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
        trx = @node.build_trx(data: activity, private_key: account.private_hex)
        r = @node.send_trx trx
        refute_nil r['trx_id']
      end

      def test_chain_data_group_info
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.group_info
        refute_nil r
      end
    end
  end
end
