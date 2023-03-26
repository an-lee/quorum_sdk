# frozen_string_literal: true

module QuorumSdk
  class API
    # Wrapper for HTTP APIs for chain
    module Management
      def allow_list(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/group/#{group_id}/trx/allowlist"
        client.get(path).body
      end

      def deny_list(group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/group/#{group_id}/trx/denylist"
        client.get(path).body
      end

      def auth_type(trx_type, group_id: nil)
        group_id ||= @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = "api/v1/group/#{group_id}/trx/auth/#{trx_type}"
        client.get(path).body
      end

      ARGUMENTS_FOR_UPDATE_CHAIN_CONFIG = %i[config type].freeze
      def update_chain_config(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_UPDATE_CHAIN_CONFIG} must be provided" unless ARGUMENTS_FOR_UPDATE_CHAIN_CONFIG.all?(&->(arg) { arg.in? kwargs.keys })

        type = kwargs[:type]
        raise ArgumentError, 'type must be one of set_trx_auth_mode/upd_alw_list/upd_dny_list' unless type.in? %w[set_trx_auth_mode upd_alw_list upd_dny_list]

        config = kwargs[:config]
        config = config.to_json if config.is_a?(Hash)

        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        path = 'api/v1/group/chainconfig'
        payload = {
          type:,
          config:,
          group_id:,
          memo: kwargs[:memo]
        }.compact
        client.post(path, **payload).body
      end

      ARGUMENTS_FOR_UPDATE_AUTH_MODE = %i[trx_auth_mode].freeze
      def update_trx_auth_mode(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_UPDATE_AUTH_MODE} must be provided" unless ARGUMENTS_FOR_UPDATE_AUTH_MODE.all?(&->(arg) { arg.in? kwargs.keys })

        trx_type = kwargs[:trx_type] || 'POST'
        raise ArgumentError, 'trx_type must be one of POST/ANNOUNCE/REQ_BLOCK_FORWARD/REQ_BLOCK_FORWARD' unless trx_type.in? %w[POST ANNOUNCE REQ_BLOCK_RESP REQ_BLOCK_BACKWARD]

        trx_auth_mode = kwargs[:trx_auth_mode]
        raise ArgumentError, 'trx_auth_mode must be one of follow_alw_list/follow_dny_list' unless trx_auth_mode.in? %w[follow_alw_list follow_dny_list]

        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        update_chain_config(
          group_id:,
          type: 'set_trx_auth_mode',
          config: {
            trx_type:,
            trx_auth_mode:
          },
          memo: kwargs[:memo]
        )
      end

      ARGUMENTS_FOR_UPDATE_ALLOW_LIST = %i[action pubkey].freeze
      def update_allow_list(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_UPDATE_ALLOW_LIST} must be provided" unless ARGUMENTS_FOR_UPDATE_ALLOW_LIST.all?(&->(arg) { arg.in? kwargs.keys })

        trx_type = kwargs[:trx_type] || ['POST']
        trx_type = [trx_type] if trx_type.is_a?(String)
        raise ArgumentError, 'trx type must be one of POST/ANNOUNCE/REQ_BLOCK_FORWARD/REQ_BLOCK_FORWARD' unless trx_type.all?(&->(op) { op.in? %w[POST ANNOUNCE REQ_BLOCK_RESP REQ_BLOCK_BACKWARD] })

        action = kwargs[:action]
        raise ArgumentError, 'trx_auth_mode must be one of add/remove' unless action.in? %w[add remove]

        pubkey = kwargs[:pubkey]
        if Eth::Util.hex?(pubkey)
          pubkey = Secp256k1::PublicKey.from_data([pubkey].pack('H*')).compressed
          pubkey = Base64.urlsafe_encode64(pubkey)
        end

        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        update_chain_config(
          group_id:,
          type: 'upd_alw_list',
          config: {
            trx_type:,
            action:,
            pubkey:
          },
          memo: kwargs[:memo]
        )
      end

      ARGUMENTS_FOR_UPDATE_DENY_LIST = %i[action pubkey].freeze
      def update_deny_list(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_UPDATE_DENY_LIST} must be provided" unless ARGUMENTS_FOR_UPDATE_DENY_LIST.all?(&->(arg) { arg.in? kwargs.keys })

        trx_type = kwargs[:trx_type] || ['POST']
        trx_type = [trx_type] if trx_type.is_a?(String)
        raise ArgumentError, 'trx type must be one of POST/ANNOUNCE/REQ_BLOCK_FORWARD/REQ_BLOCK_FORWARD' unless trx_type.all?(&->(op) { op.in? %w[POST ANNOUNCE REQ_BLOCK_RESP REQ_BLOCK_BACKWARD] })

        action = kwargs[:action]
        raise ArgumentError, 'trx_auth_mode must be one of add/remove' unless action.in? %w[add remove]

        pubkey = kwargs[:pubkey]
        if Eth::Util.hex?(pubkey)
          pubkey = Secp256k1::PublicKey.from_data([pubkey].pack('H*')).compressed
          pubkey = Base64.urlsafe_encode64(pubkey)
        end

        group_id = kwargs[:group_id] || @group_id
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        update_chain_config(
          group_id:,
          type: 'upd_dny_list',
          config: {
            trx_type:,
            action:,
            pubkey:
          },
          memo: kwargs[:memo]
        )
      end
    end
  end
end
