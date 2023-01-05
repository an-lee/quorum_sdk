# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for light node
    module LightNode
      def send_trx
        # TODO: send trx onchain
        path = "api/v1/node/trx/#{group_id}"
        client.post path
      end

      def list_trx
        # TODO: list trxs from chain
        path = "api/v1/node/groupctn/#{group_id}"
        client.get path
      end

      def chain_data
        # TODO: get chain data
        path = "api/v1/node/getchaindata/#{group_id}"
        client.get path
      end
    end
  end
end
