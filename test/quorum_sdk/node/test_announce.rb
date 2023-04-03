# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class Node
    # These tests depend on RUM server config in /config.json
    class TestAnnounce < Minitest::Test
      def setup
        @node = QuorumSdk::Node.new(seed: HTTP_SEED['seed']) if HTTP_SEED.present?
      end

      def test_announced_producers
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.announced_producers
        assert_instance_of Array, r
      end

      def test_announced_users
        if @node.blank?
          puts '**Warning**setup a RUM server for HTTP API test'
          return
        end

        r = @node.announced_users
        assert_instance_of Array, r
      end
    end
  end
end
