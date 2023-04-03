# frozen_string_literal: true

module QuorumSdk
  class Chain
    # Wrapper for HTTP APIs for chain
    module Node
      def network
        path = 'api/v1/network'
        client.get(path).body
      end

      def node
        path = 'api/v1/node'
        client.get(path).body
      end
    end
  end
end
