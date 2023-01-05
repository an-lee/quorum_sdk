# frozen_string_literal: true

require 'addressable/uri'
require 'active_support/all'
require 'base64'
require 'faraday'
require 'faraday/retry'

require_relative 'quorum_sdk/version'
require_relative 'quorum_sdk/api'
require_relative 'quorum_sdk/utils'
require_relative 'proto/activity_stream_pb'

module QuorumSdk
  class Error < StandardError; end
  # Your code goes here...
end
