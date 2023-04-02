# frozen_string_literal: true

require 'addressable/uri'
require 'active_support/all'
require 'base64'
require 'bcrypt'
require 'eth'
require 'faraday'
require 'faraday/retry'
require 'google/protobuf/well_known_types'

require_relative 'proto/activity_stream_pb'
require_relative 'proto/chain_pb'
require_relative 'quorum_sdk/account'
require_relative 'quorum_sdk/chain'
require_relative 'quorum_sdk/node'
require_relative 'quorum_sdk/utils'
require_relative 'quorum_sdk/version'

module QuorumSdk
  class Error < StandardError; end
  class ArgumentError < Error; end
end
