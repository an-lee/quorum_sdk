# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for group
    module Group
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
    end
  end
end
