# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for light node
    module LightNode
      def build_trx(**kwargs)
        kwargs = kwargs.merge(
          group_id:,
          cipher_key:
        )
        QuorumSdk::Utils.encrypt_trx(**kwargs)
      end

      def send_trx(trx_item)
        path = "api/v1/node/trx/#{group_id}"
        client.post path, TrxItem: trx_item
      end

      def list_trx(**kwargs)
        params = QuorumSdk::Utils.aes_encrypt({
          start_trx: kwargs[:start_trx],
          num: kwargs[:num],
          reverse: !kwargs[:reverse].nil?,
          include_start_trx: kwargs[:include_start_trx].presence || true,
          senders: kwargs[:senders].presence || [],
          trx_types: kwargs[:trx_types].presence || []
        }.to_json, key: cipher_key)

        payload = {
          Req: Base64.strict_encode64(params)
        }

        path = "api/v1/node/groupctn/#{group_id}"
        client.post path, **payload
      end

      def chain_data
        # TODO: get chain data
        path = "api/v1/node/getchaindata/#{group_id}"
        client.post path
      end
    end
  end
end
