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

      def encode_object(**kwargs)
        msg = Quorum::Pb::Object.new(**kwargs)
        msg.inreplyto = Quorum::Pb::Reply.new(trxid: kwargs[:inreplyto]) if kwargs[:inreplyto].present?
        # TODO: support image

        Google::Protobuf::Any.new(
          type_url: "type.googleapis.com/#{msg.class.descriptor.name}",
          value: msg.to_proto
        ).to_proto
      end

      def encrypt_person; end

      def encrypt_trx(**kwargs)
        key = Eth::Key.new priv: kwargs[:private_key]
        msg =
          Quorum::Pb::Trx.new(
            TrxId: kwargs[:trx_id] || SecureRandom.uuid,
            GroupId: kwargs[:group_id],
            Data: aes_encrypt(kwargs[:data], key: kwargs[:cipher_key]),
            TimeStamp: kwargs[:timestamp] || (Time.now.to_f * 1e9).to_i,
            Version: kwargs[:version] || '1.0.0',
            Expired: kwargs[:expired] || (30.seconds.from_now.to_f * 1e9).to_i,
            Nonce: kwargs[:nonce] || 1,
            SenderPubkey: Base64.urlsafe_encode64(key.public_bytes_compressed)
          )

        hash = Digest::SHA256.hexdigest Quorum::Pb::Trx.encode(msg)
        signature = key.sign [hash].pack('H*')
        msg.SenderSign = [signature].pack('H*')
        trx_json = {
          TrxBytes: Base64.strict_encode64(Quorum::Pb::Trx.encode(msg))
        }
        encrypted = aes_encrypt trx_json.to_json, key: kwargs[:cipher_key]
        Base64.strict_encode64(encrypted)
      end

      def decrypt_trx(cipher, **kwargs)
        cipher = Base64.strict_decode64 cipher
        trx_json = JSON.parse aes_decrypt(cipher, key: kwargs[:cipher_key])
        trx_bytes = Base64.strict_decode64 trx_json['TrxBytes']
        trx = Quorum::Pb::Trx.decode trx_bytes
        public_key_compressed = Base64.urlsafe_decode64(trx.SenderPubkey).unpack1('H*')
        signature = trx.SenderSign.unpack1('H*')

        trx_without_sig =
          Quorum::Pb::Trx.new(
            TrxId: trx.TrxId,
            GroupId: trx.GroupId,
            Data: trx.Data,
            TimeStamp: trx.TimeStamp,
            Version: trx.Version,
            Expired: trx.Expired,
            Nonce: trx.Nonce,
            SenderPubkey: trx.SenderPubkey
          )
        hash = Digest::SHA256.hexdigest Quorum::Pb::Trx.encode(trx_without_sig)

        public_key_uncompressed = Eth::Signature.recover [hash].pack('H*'), signature

        raise QuorumSdk::Error, 'Signature not verify' if public_key_uncompressed[2...66] != public_key_compressed[2...]

        decrypted_data = aes_decrypt trx.Data, key: kwargs[:cipher_key]
        obj = Google::Protobuf::Any.decode decrypted_data
        data =
          case obj.type_url.split('/').last.split('.').last
          when 'Object'
            Quorum::Pb::Object.decode obj.value
          end

        {
          trx:,
          data:
        }
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
