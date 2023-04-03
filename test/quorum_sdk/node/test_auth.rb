# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Node
    # These tests depend on RUM server config in /config.json
    class TestAuth < Minitest::Test
      def setup
        @node = QuorumSdk::Node.new(seed: HTTP_SEED['seed']) if HTTP_SEED.present?
      end

      def test_allow_list
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.allow_list
        assert_instance_of Array, r
      end

      def test_deny_list
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.deny_list
        assert_instance_of Array, r
      end

      def test_auth_type
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.auth_type
        refute_nil r['AuthType']
      end
    end
  end
end
