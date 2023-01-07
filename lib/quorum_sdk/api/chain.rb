# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for chain
    module Chain
      def trx(trx_id)
        path = "api/v1/trx/#{group_id}/#{trx_id}"
        client.get(path).body
      end
    end
  end
end
