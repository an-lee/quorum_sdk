# frozen_string_literal: true

module QuorumSdk
  class Chain
    # Wrapper for HTTP APIs for group
    module Group
      def group(group_id)
        path = "api/v1/group/#{group_id}"
        client.get(path).body
      end

      ARGUMENTS_FOR_CREATE_GROUP = %i[app_key group_name].freeze
      def create_group(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_CREATE_GROUP} must be provided" unless ARGUMENTS_FOR_CREATE_GROUP.all?(&->(arg) { arg.in? kwargs.keys })

        consensus_type = kwargs[:consensus_type] || 'poa'
        raise ArgumentError, 'consensus_type should be poa or pos' unless consensus_type.in?(%w[poa pos])

        encryption_type = kwargs[:encryption_type] || 'public'
        raise ArgumentError, 'encryption_type should be public or private' unless encryption_type.in?(%w[public private])

        path = 'api/v1/group'

        payload = {
          consensus_type:,
          encryption_type:,
          app_key: kwargs[:app_key],
          group_name: kwargs[:group_name]
        }
        client.post(path, **payload).body
      end

      def groups
        path = 'api/v1/groups'
        client.get(path).body
      end

      def seed(group_id)
        path = "api/v1/group/#{group_id}/seed"
        client.get(path).body
      end

      def join_group(seed)
        path = 'api/v2/group/join'
        payload = { seed: }
        client.post(path, **payload).body
      end

      def clear_group(group_id)
        path = 'api/v1/group/clear'
        payload = { group_id: }
        client.post(path, **payload).body
      end

      def leave_group(group_id)
        path = 'api/v1/group/leave'
        payload = { group_id: }
        client.post(path, **payload).body
      end

      def create_content(group_id, data = nil, **kwargs)
        data ||= kwargs
        path = "api/v1/group/#{group_id}/content"
        payload = { data: }
        client.post(path, **payload).body
      end
    end
  end
end
