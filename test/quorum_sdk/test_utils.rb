# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestUtils < Minitest::Test
    def test_parse_seed_url
      seed_url = "rum://seed?v=1\u0026e=0\u0026n=0\u0026b=2JAwDQsfR52nvtfghelYhQ\u0026c=ynJAEqtv4o-0cvckSseYw1jhTKWdkcMeNb-DyHGAgmQ\u0026g=nwjjfCt8SlW_tpd1hnlQ_Q\u0026k=A0f-sZyTczWntYTURuFm-xrn-p1MYiianbRqhA9hP2Nn\u0026s=0-WGiJYwFZc3dlDAQLAidVANloZsHYhWvfV5lgK5OCYCPhCXT74lqy-cYhRmeDlp_Wz1qVhooTzG3glVdBr8EAA\u0026t=FzdspvUmsfI\u0026a=my_test_group\u0026y=test_app\u0026u=http%3A%2F%2F127.0.0.1%3A8002%3Fjwt%3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyI5ZjA4ZTM3Yy0yYjdjLTRhNTUtYmZiNi05Nzc1ODY3OTUwZmQiXSwiZXhwIjoxODMwNjA1MjUxLCJuYW1lIjoiYWxsb3ctOWYwOGUzN2MtMmI3Yy00YTU1LWJmYjYtOTc3NTg2Nzk1MGZkIiwicm9sZSI6Im5vZGUifQ.0ZYlE8BbtcxGwlX1phzmk6Tpa0Yaz1vFVfiRssW47Ho"
      seed = QuorumSdk::Utils.parse_seed_url seed_url

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

      assert_equal parsed, seed
    end

    def test_encode_object
      data = {
        type: 'Note',
        name: 'Note title',
        content: 'Note body'
      }

      refute_nil QuorumSdk::Utils.encode_object(**data)
    end

    def test_sign_trx
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      key = Eth::Key.new
      data =
        QuorumSdk::Utils.encode_object(
          type: 'Note',
          name: 'Note title',
          content: 'Note body'
        )

      trx_item = QuorumSdk::Utils.encrypt_trx(
        group_id: seed[:group_id],
        data:,
        private_key: key.private_hex,
        cipher_key: seed[:cipher_key]
      )

      refute_nil trx_item
    end

    def test_decrypt_encrypted_trx
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      key = Eth::Key.new
      private_key = key.private_hex

      type = 'Note'
      name = 'Note Title'
      content = 'Note body'
      data =
        QuorumSdk::Utils.encode_object(
          type:,
          name:,
          content:
        )

      trx_item = QuorumSdk::Utils.encrypt_trx(
        data:,
        group_id: seed[:group_id],
        private_key:,
        cipher_key: seed[:cipher_key]
      )

      r = QuorumSdk::Utils.decrypt_trx(
        trx_item,
        group_id: seed[:group_id],
        private_key:,
        cipher_key: seed[:cipher_key]
      )

      assert_equal type, r[:data].type
      assert_equal name, r[:data].name
      assert_equal content, r[:data].content
    end

    def test_decrypt_outside_trx
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      group_id = 'ecea1b71-c733-429f-88c9-6bb63378c490'

      trx_item = 'RkPbRmoAowX4k9NPE7g0+o2GZiqP+NC7uXX6/+95bqay8cV8QrYdDbDhAzam3OKB14JJLBCPcIlRg3qadMSTpMe7ETs+VJ4woHewxsuGQrBzc0fgMJ948vFMLxqvGIjqmgVG6XXFi+oAfE0zW0f4XTbgiYBR0NYvajUtuRVv0rqyt1wXt0M2uhQu7Ztz8HhmRYrMGRYj5Fbgr29G4HNQtIzro3DbgCJMa5Lm0jp9/ncIfTNsEWMC8kspYCMt4a7CKks1E+iUWMRrgSkXWfGVY+jQfz7Ds7ahiStAbp/C9df3ZnmHrGzKJAM2+lSoWxX+eChD11SiOLdzr2lkOKPH1Fqtuet9Xuc+RZU8IyWEv/HjX6ONbU8OMGG40YRpRUR18k7prICCAyO62EmwcJk1PXBgckKhS0OPaKNOZj1JITHdwBgyB9MBFy7owi2ALB+QnT70f8K5TltR9YJtNumdkVc24T6qkgMZT6aZhHWVJpEkMU3VAXQGtHlBD29A3uFg9lt0hShX3blmXJ1WHN4Bm3Fq7nbhJYxPK5EdYyY8ltrqBXMP4uVEjgNpAzgvpsMWZwfhvdTgwMBrkTg='

      r = QuorumSdk::Utils.decrypt_trx(
        trx_item,
        group_id: seed[:group_id],
        cipher_key: seed[:cipher_key]
      )

      assert_equal 'Note', r[:data].type
      assert_equal 'what', r[:data].content
      assert_equal 'f6eecbcf-fa99-4f6c-bfa5-6a265c761996', r[:trx].TrxId
      assert_equal group_id, r[:trx].GroupId
    end
  end
end
