# frozen_string_literal: true

module QuorumSdk
  class Node
    # group module
    module Group
      def info(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/info"
        client.get(path).body
      end

      def producers(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/producers"
        client.get(path).body
      end

      def user_encrypt_pubkeys(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/userencryptpubkeys"
        client.get(path, **params).body
      end
    end
  end
end
