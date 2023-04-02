# frozen_string_literal: true

module QuorumSdk
  class Node
    # Auth module
    module Auth
      def allow_list(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/auth/alwlist"
        client.get(path).body
      end

      def deny_list(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/auth/denylist"
        client.get(path).body
      end

      def auth_type(group_id: nil, trx_type: 'POST')
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/auth/by/#{trx_type}"
        client.get(path).body
      end
    end
  end
end
