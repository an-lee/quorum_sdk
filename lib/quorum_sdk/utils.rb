# frozen_string_literal: true

module QuorumSdk
  # Wrapper for some useful methods
  module Utils
    class << self
      def parse_seed_url(url)
        url = Addressable::URI.parse(url.gsub(/\\u([a-f0-9]{4})/i) { [::Regexp.last_match(1).hex].pack('U') })
        query_values = url.query_values

        group_name = query_values['a']
        group_id = uuid_from_base64 query_values['g']
        block_id = uuid_from_base64 query_values['b']
        signature = Base64.strict_encode64 Base64.urlsafe_decode64(query_values['s'])
        owner_pubkey = query_values['k']
        cipher_key = Base64.urlsafe_decode64(query_values['c']).unpack1('H*')
        app_key = query_values['y']
        consensus_type = query_values['n'].to_s == '1' ? 'pos' : 'poa'
        encryption_type = query_values['e'].to_s == '0' ? 'public' : 'private'
        chain_urls = query_values['u'].split('|')

        {
          group_id:,
          group_name:,
          block_id:,
          signature:,
          owner_pubkey:,
          cipher_key:,
          app_key:,
          consensus_type:,
          encryption_type:,
          chain_urls:
        }
      end

      def uuid_from_base64(str)
        hex = Base64.urlsafe_decode64(str).unpack1('H*')
        format(
          '%<first>s-%<second>s-%<third>s-%<forth>s-%<fifth>s',
          first: hex[0..7],
          second: hex[8..11],
          third: hex[12..15],
          forth: hex[16..19],
          fifth: hex[20..]
        )
      end
    end
  end
end
