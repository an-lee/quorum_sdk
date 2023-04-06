# frozen_string_literal: true

module QuorumSdk
  # Wrapper for some useful methods
  module Utils
    TRX_VERSION = '2.0.0'

    class << self
      def parse_seed(url)
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
        chain_url = query_values['u']

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
          chain_url:
        }
      end

      def uuid_from_base64(str)
        return if str.blank?

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

      ARGUMENTS_FOR_ENCRYPT_TRX = %i[private_key group_id cipher_key data].freeze
      def build_trx(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_ENCRYPT_TRX} must be provided" unless ARGUMENTS_FOR_ENCRYPT_TRX.all?(&->(arg) { arg.in? kwargs.keys })

        data =
          case kwargs[:data]
          when Hash
            kwargs[:data].to_json
          else
            kwargs[:data].to_s
          end
        encrypted_data = aes_encrypt(data, key: kwargs[:cipher_key])

        account = QuorumSdk::Account.new priv: kwargs[:private_key]

        trx =
          Quorum::Pb::Trx.new(
            TrxId: (kwargs[:trx_id] || SecureRandom.uuid),
            GroupId: kwargs[:group_id],
            Data: encrypted_data,
            TimeStamp: (Time.now.to_f * 1e9).to_i,
            Version: (kwargs[:version] || TRX_VERSION),
            SenderPubkey: Base64.urlsafe_encode64(account.public_bytes_compressed, padding: false)
          )

        hash = Digest::SHA256.hexdigest trx.to_proto
        signature = account.sign [hash].pack('H*')
        trx.SenderSign = [signature].pack('H*')

        json = Quorum::Pb::Trx.encode_json trx
        JSON.parse(json).deep_transform_keys! { |key| key.to_s.underscore.to_sym }
      end

      def verify_trx(trx = nil, **kwargs)
        trx ||= kwargs
        trx.deep_transform_keys! { |key| key.to_s.camelize.to_sym }
        trx = trx.with_indifferent_access
        trx['TimeStamp'] = trx['TimeStamp'].to_i if trx['TimeStamp'].present? && trx['TimeStamp'].is_a?(String)
        trx['Expired'] = trx['Expired'].to_i if trx['Expired'].present? && trx['Expired'].is_a?(String)

        signature = Base64.urlsafe_decode64(trx['SenderSign']).unpack1('H*')

        trx = Quorum::Pb::Trx.new(
          TrxId: trx['TrxId'],
          GroupId: trx['GroupId'],
          Data: Base64.decode64(trx['Data']),
          TimeStamp: trx['TimeStamp'],
          Expired: trx['Expired'],
          Version: trx['Version'],
          SenderPubkey: trx['SenderPubkey']
        )

        hash = Digest::SHA256.hexdigest trx.to_proto
        public_key = Secp256k1::PublicKey.from_data(Base64.urlsafe_decode64(trx.SenderPubkey)).uncompressed.unpack1('H*')
        recover_key = Eth::Signature.recover [hash].pack('H*'), signature

        public_key == recover_key
      end

      def decrypt_trx_data(cipher, key:)
        decrypted_data = aes_decrypt(cipher, key:)
        begin
          JSON.parse(decrypted_data).with_indifferent_access
        rescue JSON::ParserError
          decrypted_data
        end
      end

      def aes_encrypt(data, key:)
        encipher = OpenSSL::Cipher.new('aes-256-gcm').encrypt
        encipher.key = [key].pack('H*')
        iv = encipher.random_iv
        encipher.iv = iv
        encrypted = encipher.update(data) + encipher.final
        [
          iv,
          encrypted,
          encipher.auth_tag
        ].join
      end

      def aes_decrypt(cipher, key:)
        decipher = OpenSSL::Cipher.new('aes-256-gcm').decrypt
        decipher.key = [key].pack('H*')
        decipher.iv = cipher[...12]
        decipher.auth_tag = cipher[-16...]
        decipher.update(cipher[12...-16]) + decipher.final
      end

      def decode_jwt(token)
        JWT.decode token, nil, false
      end
    end
  end
end
