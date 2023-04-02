# frozen_string_literal: true

module QuorumSdk
  class Node
    # Wrapper for HTTP APIs as light node client
    module Trx
      ARGUMENTS_FOR_BUILD_TRX = %i[private_key data].freeze
      def build_trx(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_BUILD_TRX} must be provided" unless ARGUMENTS_FOR_BUILD_TRX.all?(&->(arg) { arg.in? kwargs.keys })

        kwargs = kwargs.merge(
          group_id:,
          cipher_key:
        )
        QuorumSdk::Utils.encrypt_trx(**kwargs)
      end

      def send_trx(trx_item)
        path = "api/v1/node/trx/#{group_id}"
        client.post(path, TrxItem: trx_item).body
      end

      def list_trx(**kwargs)
        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        cipher_key = kwargs[:cipher_key] || @cipher_key

        params = {
          group_id:,
          start_trx: kwargs[:start_trx],
          num: kwargs[:num] || 100,
          senders: kwargs[:senders],
          reverse: kwargs[:reverse],
          include_start_trx: kwargs[:include_start_trx]
        }.compact

        path = "api/v1/node/#{group_id}/groupctn"
        list = client.get(path, **params).body

        return list unless list.is_a?(Array)
        return list if cipher_key.blank?

        list.each do |trx|
          next if trx['Data'].blank?

          data = Base64.strict_decode64 trx['Data']
          trx['Data'] = QuorumSdk::Utils.decrypt_trx_data data, key: cipher_key
        end

        list
      end

      def chain_data(params, type)
        path = "api/v1/node/getchaindata/#{group_id}"
        encrypted_params = QuorumSdk::Utils.aes_encrypt params.to_json, key: cipher_key
        encoded_params = Base64.strict_encode64 encrypted_params

        payload = {
          Req: encoded_params,
          ReqType: type
        }

        client.post(path, **payload).body
      end

      def group_info
        chain_data({ GroupId: group_id }, 'group_info')
      end
    end
  end
end
