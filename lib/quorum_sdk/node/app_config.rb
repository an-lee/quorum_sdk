# frozen_string_literal: true

module QuorumSdk
  class Node
    # Appconfig module
    module AppConfig
      def app_config(key, group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?
        raise ArgumentError, 'key must be provided' if key.blank?

        path = "api/v1/node/#{group_id}/appconfig/by/#{key}"
        client.get(path).body
      end

      def app_config_keys(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/node/#{group_id}/appconfig/keylist"
        client.get(path).body
      end
    end
  end
end
