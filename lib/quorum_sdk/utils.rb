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

      ARGUMENTS_FOR_ENCRYPT_TRX = %i[private_key group_id cipher_key data].freeze
      def encrypt_trx(**kwargs)
        raise ArgumentError, "Keyword arguments #{ARGUMENTS_FOR_ENCRYPT_TRX} must be provided" unless ARGUMENTS_FOR_ENCRYPT_TRX.all?(&->(arg) { arg.in? kwargs.keys })
        raise ArgumentError, 'data should be instance of Google::Protobuf::MessageExts' unless kwargs[:data].is_a?(Google::Protobuf::MessageExts)

        data = Google::Protobuf::Any.new(
          type_url: "type.googleapis.com/#{kwargs[:data].class.descriptor.name}",
          value: kwargs[:data].to_proto
        ).to_proto
        encrypted_data = aes_encrypt data, key: kwargs[:cipher_key]

        key = Eth::Key.new priv: kwargs[:private_key]

        msg =
          Quorum::Pb::Trx.new(
            TrxId: (kwargs[:trx_id] || SecureRandom.uuid),
            GroupId: kwargs[:group_id],
            Data: encrypted_data,
            TimeStamp: (kwargs[:timestamp].to_i || (Time.now.to_f * 1e9).to_i),
            Version: (kwargs[:version] || '1.0.0'),
            Expired: (kwargs[:expired].to_i || (30.seconds.from_now.to_f * 1e9).to_i),
            Nonce: (kwargs[:nonce] || 1),
            SenderPubkey: Base64.urlsafe_encode64(key.public_bytes_compressed, padding: false)
          )

        hash = Digest::SHA256.hexdigest msg.to_proto
        signature = key.sign [hash].pack('H*')
        msg.SenderSign = [signature].pack('H*')
        trx_json = {
          TrxBytes: Base64.strict_encode64(msg.to_proto)
        }
        encrypted = aes_encrypt trx_json.to_json, key: kwargs[:cipher_key]
        Base64.strict_encode64 encrypted
      end

      def decrypt_trx(cipher, key:)
        cipher = Base64.strict_decode64 cipher
        trx_json = JSON.parse aes_decrypt(cipher, key:)
        trx_bytes = Base64.strict_decode64 trx_json['TrxBytes']
        trx = Quorum::Pb::Trx.decode trx_bytes
        public_key_compressed = Base64.urlsafe_decode64(trx.SenderPubkey).unpack1('H*')
        signature = trx.SenderSign.unpack1('H*')

        trx_without_sig = trx.dup
        trx_without_sig.clear_SenderSign
        hash = Digest::SHA256.hexdigest Quorum::Pb::Trx.encode(trx_without_sig)

        public_key_uncompressed = Eth::Signature.recover [hash].pack('H*'), signature

        raise QuorumSdk::Error, 'Signature not verified' if public_key_uncompressed[2...66] != public_key_compressed[2...]

        decrypted_data = aes_decrypt(trx.Data, key:)
        obj = Google::Protobuf::Any.decode decrypted_data
        msgclass = ::Google::Protobuf::DescriptorPool.generated_pool.lookup(obj.type_url.split('/').last).msgclass
        data = msgclass.decode obj.value

        trx = JSON.parse Quorum::Pb::Trx.encode_json(trx)
        trx['Data'] = JSON.parse(msgclass.encode_json(data))
        trx.with_indifferent_access
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
    end
  end
end
