# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for chain
    module Chain
      def trx(trx_id)
        path = "api/v1/trx/#{group_id}/#{trx_id}"
        r = client.get(path).body
        r =
          begin
            JSON.parse r
          rescue JSON::ParserError
            r
          end

        if r['Data'].present?
          data = Base64.strict_decode64 r['Data']
          r['Data'] = QuorumSdk::Utils.decrypt_trx_data data, key: cipher_key
        end

        r
      end
    end
  end
end
