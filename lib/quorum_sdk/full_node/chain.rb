# frozen_string_literal: true

module QuorumSdk
  class FullNode
    # Wrapper for HTTP APIs for chain
    module Chain
      def trx(trx_id, group_id:)
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/trx/#{group_id}/#{trx_id}"
        r = client.get(path).body
        r =
          begin
            JSON.parse r
          rescue JSON::ParserError
            r
          end

        group = groups['groups'].find(&->(g) { g['group_id'] == group_id })

        if r['Data'].present? && group.present?
          data = Base64.strict_decode64 r['Data']
          r['Data'] = QuorumSdk::Utils.decrypt_trx_data data, key: group['cipher_key']
        end

        r
      end
    end
  end
end
