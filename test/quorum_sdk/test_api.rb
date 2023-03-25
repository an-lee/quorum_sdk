# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestAPI < Minitest::Test
    def test_api_may_initialize_by_seed_url
      refute_nil QuorumSdk::API.new seed_url: SEED_URL
    end

    def test_api_may_initialize_by_config
      refute_nil QuorumSdk::API.new(
        group_id: '9f08e37c-2b7c-4a55-bfb6-9775867950fd',
        group_name: 'my_test_group',
        cipher_key: 'ca724012ab6fe28fb472f7244ac798c358e14ca59d91c31e35bf83c871808264',
        owner_pubkey: 'A0f-sZyTczWntYTURuFm-xrn-p1MYiianbRqhA9hP2Nn',
        chain_url: 
          'http://127.0.0.1:8002?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyI5ZjA4ZTM3Yy0yYjdjLTRhNTUtYmZiNi05Nzc1ODY3OTUwZmQiXSwiZXhwIjoxODMwNjA1MjUxLCJuYW1lIjoiYWxsb3ctOWYwOGUzN2MtMmI3Yy00YTU1LWJmYjYtOTc3NTg2Nzk1MGZkIiwicm9sZSI6Im5vZGUifQ.0ZYlE8BbtcxGwlX1phzmk6Tpa0Yaz1vFVfiRssW47Ho'
      )
    end
  end
end
