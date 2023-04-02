# frozen_string_literal: true

module QuorumSdk
  class Node
    # Announce module
    module Announce
      def announce(**kwargs)
        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        payload = {
          data: {
            Action: kwargs[:action],
            AnnouncerSignature: kwargs[:announce_signature],
            EncryptPubkey: kwargs[:encrypt_pubkey],
            GroupId: group_id,
            Memo: kwargs[:memo],
            OwnerPubkey: kwargs[:owner_pubkey],
            OwnerSignature: kwargs[:owner_signature],
            Result: kwargs[:result],
            SignPubkey: kwargs[:sign_pubkey],
            TimeStamp: kwargs[:timestamp],
            Type: kwargs[:type]
          }
        }

        path = "/api/v1/node/#{group_id}/announce"
        client.post(path, **payload).body
      end

      def announced_producers(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "/api/v1/node/#{group_id}/announced/producer"
        client.get(path).body
      end

      def announced_users(group_id: nil, pubkey: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        params = {
          pubkey:
        }.compact

        path = "/api/v1/node/#{group_id}/announced/user"
        client.get(path, **params).body
      end
    end
  end
end
