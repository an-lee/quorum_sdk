# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Node
    # These tests depend on RUM server config in /config.json
    class TestAppConfig < Minitest::Test
      def setup
        @node = QuorumSdk::Node.new(seed: HTTP_SEED['seed']) if HTTP_SEED.present?
      end

      def test_app_config
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.app_config 'rum'
        assert_instance_of Hash, r
      end

      def test_app_config_keys
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.app_config_keys
        assert_instance_of Array, r
      end
    end
  end
end
