# frozen_string_literal: true

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: lib/proto/activity_stream.proto

require 'google/protobuf'

require 'google/protobuf/timestamp_pb'
require 'google/protobuf/any_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file('lib/proto/activity_stream.proto', syntax: :proto3) do
    add_message 'quorum.pb.AnyObj' do
      optional :any, :message, 1, 'google.protobuf.Any'
    end
    add_message 'quorum.pb.Object' do
      optional :id, :string, 1
      optional :type, :string, 2
      repeated :attachments, :message, 3, 'quorum.pb.Object'
      repeated :attributedTo, :message, 4, 'quorum.pb.Object'
      optional :audience, :message, 5, 'quorum.pb.Object'
      optional :content, :string, 6
      optional :context, :message, 7, 'quorum.pb.Object'
      optional :name, :string, 8
      optional :endtime, :message, 9, 'google.protobuf.Timestamp'
      optional :generator, :message, 10, 'quorum.pb.Object'
      repeated :icon, :message, 11, 'quorum.pb.Object'
      repeated :image, :message, 12, 'quorum.pb.Image'
      optional :inreplyto, :message, 13, 'quorum.pb.Reply'
      optional :location, :message, 14, 'quorum.pb.Object'
      optional :preview, :message, 15, 'quorum.pb.Object'
      optional :published, :message, 16, 'google.protobuf.Timestamp'
      optional :replies, :message, 17, 'quorum.pb.Object'
      optional :startTime, :message, 18, 'google.protobuf.Timestamp'
      optional :summary, :string, 19
      repeated :tag, :message, 20, 'quorum.pb.Object'
      optional :updated, :message, 21, 'google.protobuf.Timestamp'
      repeated :url, :message, 22, 'quorum.pb.Link'
      repeated :to, :message, 23, 'quorum.pb.Object'
      repeated :bto, :message, 24, 'quorum.pb.Object'
      repeated :cc, :message, 25, 'quorum.pb.Object'
      repeated :bcc, :message, 26, 'quorum.pb.Object'
      optional :mediaType, :string, 27
      optional :duration, :string, 28
      optional :file, :message, 29, 'quorum.pb.File'
    end
    add_message 'quorum.pb.Link' do
      optional :href, :string, 1
      repeated :rel, :string, 2
      optional :mediaType, :string, 3
      optional :name, :string, 4
      optional :hreflang, :string, 5
      optional :height, :uint32, 6
      optional :width, :uint32, 7
      optional :preview, :message, 8, 'quorum.pb.Object'
    end
    add_message 'quorum.pb.Reply' do
      optional :trxid, :string, 1
      optional :groupid, :string, 2
    end
    add_message 'quorum.pb.Image' do
      optional :id, :string, 1
      optional :name, :string, 2
      optional :mediaType, :string, 3
      optional :content, :bytes, 4
      optional :url, :string, 5
    end
    add_message 'quorum.pb.File' do
      optional :id, :string, 1
      optional :name, :string, 2
      optional :mediaType, :string, 3
      optional :compression, :enum, 4, 'quorum.pb.File.Compression'
      optional :content, :bytes, 5
      optional :url, :string, 6
    end
    add_enum 'quorum.pb.File.Compression' do
      value :none, 0
      value :gz, 1
      value :zip, 2
      value :zstd, 3
    end
    add_message 'quorum.pb.Person' do
      optional :id, :string, 1
      optional :name, :string, 2
      optional :image, :message, 3, 'quorum.pb.Image'
      repeated :wallet, :message, 11, 'quorum.pb.Payment'
    end
    add_message 'quorum.pb.Payment' do
      optional :id, :string, 1
      optional :type, :string, 2
      optional :name, :string, 3
    end
    add_message 'quorum.pb.Activity' do
      optional :id, :string, 1
      optional :type, :string, 2
      repeated :attachments, :message, 3, 'quorum.pb.Object'
      repeated :attributedTo, :message, 4, 'quorum.pb.Object'
      optional :audience, :message, 5, 'quorum.pb.Object'
      optional :content, :string, 6
      optional :context, :message, 7, 'quorum.pb.Object'
      optional :name, :string, 8
      optional :endtime, :message, 9, 'google.protobuf.Timestamp'
      optional :generator, :message, 10, 'quorum.pb.Object'
      repeated :icon, :message, 11, 'quorum.pb.Object'
      repeated :image, :message, 12, 'quorum.pb.Object'
      optional :inReplyTo, :message, 13, 'quorum.pb.Object'
      optional :location, :message, 14, 'quorum.pb.Object'
      optional :preview, :message, 15, 'quorum.pb.Object'
      optional :published, :message, 16, 'google.protobuf.Timestamp'
      optional :replies, :message, 17, 'quorum.pb.Object'
      optional :startTime, :message, 18, 'google.protobuf.Timestamp'
      optional :summary, :string, 19
      repeated :tag, :message, 20, 'quorum.pb.Object'
      optional :updated, :message, 21, 'google.protobuf.Timestamp'
      repeated :url, :message, 22, 'quorum.pb.Link'
      repeated :to, :message, 23, 'quorum.pb.Object'
      repeated :bto, :message, 24, 'quorum.pb.Object'
      repeated :cc, :message, 25, 'quorum.pb.Object'
      repeated :bcc, :message, 26, 'quorum.pb.Object'
      optional :mediaType, :string, 27
      optional :duration, :string, 28
      optional :actor, :message, 29, 'quorum.pb.Object'
      optional :object, :message, 30, 'quorum.pb.Object'
      optional :target, :message, 31, 'quorum.pb.Object'
      optional :result, :message, 32, 'quorum.pb.Object'
      optional :origin, :message, 33, 'quorum.pb.Object'
      optional :instrument, :message, 34, 'quorum.pb.Object'
      optional :person, :message, 35, 'quorum.pb.Person'
    end
  end
end

module Quorum
  module Pb
    AnyObj = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AnyObj').msgclass
    Object = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Object').msgclass
    Link = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Link').msgclass
    Reply = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Reply').msgclass
    Image = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Image').msgclass
    File = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.File').msgclass
    File::Compression = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.File.Compression').enummodule
    Person = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Person').msgclass
    Payment = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Payment').msgclass
    Activity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Activity').msgclass
  end
end
