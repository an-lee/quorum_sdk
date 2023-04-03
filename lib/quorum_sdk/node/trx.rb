# frozen_string_literal: true

module QuorumSdk
  class Node
    # Wrapper for HTTP APIs as light node client
    module Trx
      ARGUMENTS_FOR_BUILD_TRX = %i[private_key data].freeze
      def build_trx(**kwargs)
        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        cipher_key = kwargs[:cipher_key] || @cipher_key
        raise ArgumentError, 'cipher_key must be provided' if cipher_key.blank?

        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_BUILD_TRX} must be provided" unless ARGUMENTS_FOR_BUILD_TRX.all?(&->(arg) { arg.in? kwargs.keys })

        kwargs = kwargs.merge(
          group_id:,
          cipher_key:
        )
        QuorumSdk::Utils.build_trx(**kwargs)
      end

      ARGUMENTS_FOR_SEND_TRX = %i[data sender_pubkey sender_sign trx_id version].freeze
      def send_trx(trx = nil, **kwargs)
        trx ||= kwargs
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_SEND_TRX} must be provided" unless ARGUMENTS_FOR_SEND_TRX.all?(&->(arg) { arg.in? trx.keys })

        group_id = trx[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        payload = {
          data: trx[:data],
          sender_pubkey: trx[:sender_pubkey],
          sender_sign: trx[:sender_sign],
          timestamp: trx[:time_stamp] || trx[:timestamp],
          trx_id: trx[:trx_id],
          version: trx[:version]
        }.compact
        payload.deep_transform_values!(&->(v) { v.is_a?(String) ? v : v.to_s })

        path = "api/v1/node/#{group_id}/trx"
        client.post(path, **payload).body
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
          trx['DecryptedData'] = QuorumSdk::Utils.decrypt_trx_data data, key: cipher_key
        end

        list
      end
    end
  end
end
