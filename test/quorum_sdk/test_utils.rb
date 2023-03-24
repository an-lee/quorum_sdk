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

    def test_sign_trx
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      data = Quorum::Pb::Object.new(
        type: 'Note',
        content: 'What'
      )

      trx_item = QuorumSdk::Utils.encrypt_trx(
        trx_id: 'f6eecbcf-fa99-4f6c-bfa5-6a265c761996',
        group_id: seed[:group_id],
        data:,
        private_key: '0xd6c48ca889e67a07578e0709760f1b682fd52244b6a885f00bd17a84475948b5',
        cipher_key: seed[:cipher_key],
        timestamp: 1_672_991_304_952_999_936,
        expired: 1_672_991_334_953_000_000,
        nonce: 1
      )

      refute_nil trx_item
    end

    def test_decrypt_encrypted_trx
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      account = QuorumSdk::Account.new
      private_key = account.private_hex

      type = 'Note'
      name = 'Note Title'
      content = 'Note body'
      article = {
        type:,
        name:,
        content:
      }
      data = {
        type: 'Create',
        object: article
      }

      trx_item = QuorumSdk::Utils.encrypt_trx(
        data:,
        group_id: seed[:group_id],
        private_key:,
        cipher_key: seed[:cipher_key]
      )

      trx = QuorumSdk::Utils.decrypt_trx(
        trx_item,
        key: seed[:cipher_key]
      )

      assert_equal 'Create', trx['Data']['type']
      assert_equal type, trx['Data']['object']['type']
      assert_equal name, trx['Data']['object']['name']
      assert_equal content, trx['Data']['object']['content']
    end

    def test_decrypt_outside_trx
      seed = QuorumSdk::Utils.parse_seed_url SEED_URL
      trx_id = 'f6eecbcf-fa99-4f6c-bfa5-6a265c761996'

      trx_item = 'RkPbRmoAowX4k9NPE7g0+o2GZiqP+NC7uXX6/+95bqay8cV8QrYdDbDhAzam3OKB14JJLBCPcIlRg3qadMSTpMe7ETs+VJ4woHewxsuGQrBzc0fgMJ948vFMLxqvGIjqmgVG6XXFi+oAfE0zW0f4XTbgiYBR0NYvajUtuRVv0rqyt1wXt0M2uhQu7Ztz8HhmRYrMGRYj5Fbgr29G4HNQtIzro3DbgCJMa5Lm0jp9/ncIfTNsEWMC8kspYCMt4a7CKks1E+iUWMRrgSkXWfGVY+jQfz7Ds7ahiStAbp/C9df3ZnmHrGzKJAM2+lSoWxX+eChD11SiOLdzr2lkOKPH1Fqtuet9Xuc+RZU8IyWEv/HjX6ONbU8OMGG40YRpRUR18k7prICCAyO62EmwcJk1PXBgckKhS0OPaKNOZj1JITHdwBgyB9MBFy7owi2ALB+QnT70f8K5TltR9YJtNumdkVc24T6qkgMZT6aZhHWVJpEkMU3VAXQGtHlBD29A3uFg9lt0hShX3blmXJ1WHN4Bm3Fq7nbhJYxPK5EdYyY8ltrqBXMP4uVEjgNpAzgvpsMWZwfhvdTgwMBrkTg='

      trx = QuorumSdk::Utils.decrypt_trx(
        trx_item,
        key: seed[:cipher_key]
      )

      refute_nil trx[:Data]
      assert_equal trx_id, trx[:TrxId]
      assert_equal seed[:group_id], trx[:GroupId]
    end
  end
end
