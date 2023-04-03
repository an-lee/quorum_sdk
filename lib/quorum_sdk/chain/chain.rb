# frozen_string_literal: true

module QuorumSdk
  class Chain
    # Wrapper for HTTP APIs for chain
    module Chain
      def block(group_id, _block_id)
        path = "api/v1/block/#{group_id}/#{trx_id}"
        client.get(path).body
      end

      def trx(group_id, trx_id)
        path = "api/v1/trx/#{group_id}/#{trx_id}"
        client.get(path).body
      end
    end
  end
end
