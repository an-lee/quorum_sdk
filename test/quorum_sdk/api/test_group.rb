# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class API
    class TestGroup < Minitest::Test
      def setup
        seed = QuorumSdk::Utils.parse_seed_url(HTTP_SEED_URL['seed_url']) if HTTP_SEED_URL.present?
        return if seed.blank?

        @api = QuorumSdk::API.new(
          group_id: seed[:group_id],
          chain_url: seed[:chain_url]
        )
      end

      def test_create_public_group
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.create_group app_key: 'my_test_app', group_name: "A public group-#{SecureRandom.uuid}"
        refute_nil r['group_id']
        refute_nil r['seed']
      end

      def test_create_private_group
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.create_group(
          app_key: 'my_test_app',
          group_name: "A private group-#{SecureRandom.uuid}",
          encryption_type: 'private'
        )
        refute_nil r['group_id']
        refute_nil r['seed']
      end

      def test_list_groups
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @api.groups
        refute_nil r['groups']
      end

      def test_group_seed
        if @api.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        group_id = @api.group_id
        r = @api.seed group_id
        refute_nil r['seed']
      end
    end
  end
end
