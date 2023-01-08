# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for light node
    module LightNode
      ARGUMENTS_FOR_BUILD_TRX = %i[private_key data].freeze
      def build_trx(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_BUILD_TRX} must be provided" unless ARGUMENTS_FOR_BUILD_TRX.all?(&->(arg) { arg.in? kwargs.keys })
        raise ArgumentError, 'data should be instance of Google::Protobuf::MessageExts' unless kwargs[:data].is_a?(Google::Protobuf::MessageExts)

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
        params = {
          group_id:,
          start_trx: kwargs[:start_trx],
          num: kwargs[:num] || 100,
          senders: kwargs[:senders].presence || []
        }.compact
        params[:reverse] =
          if kwargs[:reverse]
            'true'
          else
            'false'
          end
        params[:include_start_trx] =
          if kwargs[:include_start_trx]
            'true'
          else
            'false'
          end

        encrypted_params = QuorumSdk::Utils.aes_encrypt({
          Req: params
        }.to_json, key: cipher_key)

        payload = {
          Req: Base64.strict_encode64(encrypted_params)
        }

        path = "api/v1/node/groupctn/#{group_id}"
        list = client.post(path, **payload).body

        return list unless list.is_a?(Array)

        list.each do |trx|
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
