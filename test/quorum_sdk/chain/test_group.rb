# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Chain
    # These tests depend on RUM server config in /config.json
    class TestGroup < Minitest::Test
      def setup
        return if HTTP_SEED.blank?

        @node = QuorumSdk::FullNode.new(
          chain_url: HTTP_SEED['chain_url'],
          jwt: HTTP_SEED['jwt']
        )
      end

      def test_create_public_group
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.create_group app_key: 'my_test_app', group_name: "A public group-#{SecureRandom.uuid}"
        refute_nil r['group_id']
        refute_nil r['seed']
      end

      def test_create_private_group
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.create_group(
          app_key: 'my_test_app',
          group_name: "A private group-#{SecureRandom.uuid}",
          encryption_type: 'private'
        )
        refute_nil r['group_id']
        refute_nil r['seed']
      end

      def test_list_groups
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.groups
        refute_nil r['groups']
      end

      def test_group_seed
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        group_id = @node.groups['groups'].first['group_id']
        r = @node.seed group_id
        refute_nil r['seed']
      end
    end
  end
end
