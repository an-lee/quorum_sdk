# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Node
    # These tests depend on RUM server config in /config.json
    class TestGroup < Minitest::Test
      def setup
        @node = QuorumSdk::Node.new(seed: HTTP_SEED['seed']) if HTTP_SEED.present?
      end

      def test_group_info
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.info
        refute_nil r['group_id']
      end

      def test_producers
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.producers
        assert_instance_of Array, r
      end

      def test_user_encrypt_pubkeys
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.user_encrypt_pubkeys
        assert_instance_of Array, r
      end
    end
  end
end
