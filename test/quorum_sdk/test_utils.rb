# frozen_string_literal: true

require 'test_helper'

module QuorumSdk
  class TestUtils < Minitest::Test
    def test_parse_seed
      seed = "rum://seed?v=1\u0026e=0\u0026n=0\u0026b=2JAwDQsfR52nvtfghelYhQ\u0026c=ynJAEqtv4o-0cvckSseYw1jhTKWdkcMeNb-DyHGAgmQ\u0026g=nwjjfCt8SlW_tpd1hnlQ_Q\u0026k=A0f-sZyTczWntYTURuFm-xrn-p1MYiianbRqhA9hP2Nn\u0026s=0-WGiJYwFZc3dlDAQLAidVANloZsHYhWvfV5lgK5OCYCPhCXT74lqy-cYhRmeDlp_Wz1qVhooTzG3glVdBr8EAA\u0026t=FzdspvUmsfI\u0026a=my_test_group\u0026y=test_app\u0026u=http%3A%2F%2F127.0.0.1%3A8002%3Fjwt%3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyI5ZjA4ZTM3Yy0yYjdjLTRhNTUtYmZiNi05Nzc1ODY3OTUwZmQiXSwiZXhwIjoxODMwNjA1MjUxLCJuYW1lIjoiYWxsb3ctOWYwOGUzN2MtMmI3Yy00YTU1LWJmYjYtOTc3NTg2Nzk1MGZkIiwicm9sZSI6Im5vZGUifQ.0ZYlE8BbtcxGwlX1phzmk6Tpa0Yaz1vFVfiRssW47Ho"
      seed = QuorumSdk::Utils.parse_seed seed

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
        chain_url: ['http://127.0.0.1:8002?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyI5ZjA4ZTM3Yy0yYjdjLTRhNTUtYmZiNi05Nzc1ODY3OTUwZmQiXSwiZXhwIjoxODMwNjA1MjUxLCJuYW1lIjoiYWxsb3ctOWYwOGUzN2MtMmI3Yy00YTU1LWJmYjYtOTc3NTg2Nzk1MGZkIiwicm9sZSI6Im5vZGUifQ.0ZYlE8BbtcxGwlX1phzmk6Tpa0Yaz1vFVfiRssW47Ho']
      }

      assert_equal parsed, seed
    end

    def test_build_trx
      seed = QuorumSdk::Utils.parse_seed SEED
      data = {
        type: 'Note',
        content: 'What'
      }

      trx = QuorumSdk::Utils.build_trx(
        trx_id: 'f6eecbcf-fa99-4f6c-bfa5-6a265c761996',
        group_id: seed[:group_id],
        data:,
        private_key: '0xd6c48ca889e67a07578e0709760f1b682fd52244b6a885f00bd17a84475948b5',
        cipher_key: seed[:cipher_key],
        timestamp: 1_672_991_304_952_999_936
      )

      refute_nil trx[:sender_pubkey]
      refute_nil trx[:sender_sign]
      refute_nil trx[:data]
      refute_nil trx[:trx_id]
    end

    def test_valid_built_trx
      seed = QuorumSdk::Utils.parse_seed SEED
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

      trx = QuorumSdk::Utils.build_trx(
        data:,
        group_id: seed[:group_id],
        private_key:,
        cipher_key: seed[:cipher_key]
      )

      assert QuorumSdk::Utils.verify_trx(**trx)
    end

    def test_verify_trx_from_go
      trx =
        {
          GroupId: '9d0966b6-4e0c-4b0b-99cc-1c8891d0d264',
          Data: 'wRiA0iO6zM+4bOcmEaCzUqlxf/08GmvOWQXi/06tIqSx2HEVF7RE6Ag4dZOHGCLzTzlNnnAB5Sj1HzyadEI5eOBxdO7ZRN1Z+N+PU8WkRe4CD2z9GjRtWcYeYQ55lu27/HVK9yNAG4tUkRGyCmBwlOc11i1CXJ1Oy3FifCyDDVK5c86iTQ0Osx4cdGuobQ==',
          SenderPubkey: 'AmSGoLh7Sibt9bB4Evmbr8zqfOFwH9aQz6R0dzRsE-zf',
          SenderSign: 'jyzXY+ryPOt04ARxorJTnBzylIw2NnFxWNB1wHLp2AV9Pc0h0dAyGD2e7R0Dx3dxpvwQGgri35tvucQP95LmUQA=',
          TimeStamp: '1680151626438620000',
          Expired: '1680151656438620000',
          TrxId: '888fea18-a417-4ca6-9216-a34082d2e833',
          Version: '2.0.0'
        }

      assert QuorumSdk::Utils.verify_trx trx
    end

    def test_verify_trx_from_js
      trx =
        {
          GroupId: 'caeeac75-62e8-4e0b-9ac7-a78c6f8ac7f8',
          Data: 'eWxn/oYsJdUPVvJwkmvl0glHMO0P8SYSQUzsoyXgQhuhJ4aA66evPAL0kXhJuGlw7oVW+WK+FpZ/xyWSvr5rTRFfEYWxJfVqD1g5TnqRq3uEvM4J/6YtQJa8weGe7bsBYbMAOcuN9Q==',
          SenderPubkey: 'A8hfNDAUJzdndxfHbZ3BrcooEY5zpMy9ajEk18mnh81V',
          SenderSign: '9j26OsO1FDzj+3arU+9H9pTKTnqGjhKdP9EQ1JC1BZNwbzoZVZRKtqnpCHhVsRr9TyhAuxUGsR1VX8wjorkcbxs=',
          TimeStamp: '1680148475255123456',
          TrxId: '1621db68-c9b8-4654-bcba-014c68580791',
          Version: '2.0.0'
        }

      assert QuorumSdk::Utils.verify_trx trx
    end
  end
end
