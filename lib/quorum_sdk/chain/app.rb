# frozen_string_literal: true

module QuorumSdk
  class Chain
    # Wrapper for HTTP APIs for group
    module App
      def list_trx(group_id = nil, **kwargs)
        group_id ||= kwargs[:group_id]
        raise ArgumentError, 'group_id must be provided' if group_id.blank?

        params = {
          group_id:,
          start_trx: kwargs[:start_trx],
          num: kwargs[:num] || 100,
          senders: kwargs[:senders],
          reverse: kwargs[:reverse],
          include_start_trx: kwargs[:include_start_trx]
        }.compact

        path = "/app/api/v1/group/#{group_id}/content"

        list = client.get(path).body

        return list unless list.is_a?(Array)

        cipher_key = kwargs[:cipher_key]
        return list if cipher_key.blank?

        list.each do |trx|
          next if trx['Data'].blank?

          data = Base64.strict_decode64 trx['Data']
          trx['DecryptedData'] = QuorumSdk::Utils.decrypt_trx_data data, key: cipher_key
        end

        list
      end

      def list_token
        path = '/app/api/v1/token/list'
        client.get(path).body
      end

      def create_token(**kwargs)
        path = '/app/api/v1/token/create'
        payload = {
          expires_at: kwargs[:expires_at],
          group_id: kwargs[:group_id],
          name: kwargs[:name],
          role: kwargs[:role]
        }
        client.post(path, **payload).body
      end
    end
  end
end
