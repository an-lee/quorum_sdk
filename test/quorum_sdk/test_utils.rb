# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestUtils < Minitest::Test
    def test_parse_seed_url
      r = QuorumSdk::Utils.parse_seed_url SEED_URL

      parsed = {
        group_id: '9f08e37c-2b7c-4a55-bfb6-9775867950fd',
        group_name: 'my_test_group',
        block_id: 'd890300d-0b1f-479d-a7be-d7e085e95885',
        signature: '0+WGiJYwFZc3dlDAQLAidVANloZsHYhWvfV5lgK5OCYCPhCXT74lqy+cYhRmeDlp/Wz1qVhooTzG3glVdBr8EAA=',
        owner_pubkey: 'A0f-sZyTczWntYTURuFm-xrn-p1MYiianbRqhA9hP2Nn',
        cipher_key: 'ca724012ab6fe28fb472f7244ac798c358e14ca59d91c31e35bf83c871808264',
        app_key: 'test_app',
        consensus_type: 'poa',
        encryption_type: 'public',
        chain_urls: [
          'http://127.0.0.1:8002?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyI5ZjA4ZTM3Yy0yYjdjLTRhNTUtYmZiNi05Nzc1ODY3OTUwZmQiXSwiZXhwIjoxODMwNjA1MjUxLCJuYW1lIjoiYWxsb3ctOWYwOGUzN2MtMmI3Yy00YTU1LWJmYjYtOTc3NTg2Nzk1MGZkIiwicm9sZSI6Im5vZGUifQ.0ZYlE8BbtcxGwlX1phzmk6Tpa0Yaz1vFVfiRssW47Ho'
        ]
      }

      assert_equal parsed, r
    end
  end
end
