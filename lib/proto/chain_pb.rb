# frozen_string_literal: true

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: chain.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file('chain.proto', syntax: :proto3) do
    add_message 'quorum.pb.Package' do
      optional :type, :enum, 1, 'quorum.pb.PackageType'
      optional :Data, :bytes, 2
    end
    add_message 'quorum.pb.Trx' do
      optional :TrxId, :string, 1
      optional :Type, :enum, 2, 'quorum.pb.TrxType'
      optional :GroupId, :string, 3
      optional :Data, :bytes, 4
      optional :TimeStamp, :int64, 5
      optional :Version, :string, 6
      optional :Expired, :int64, 7
      optional :ResendCount, :int64, 8
      optional :SenderPubkey, :string, 10
      optional :SenderSign, :bytes, 11
      optional :StorageType, :enum, 12, 'quorum.pb.TrxStroageType'
    end
    add_message 'quorum.pb.Block' do
      optional :GroupId, :string, 1
      optional :BlockId, :uint64, 2
      optional :Epoch, :uint64, 3
      optional :PrevHash, :bytes, 4
      optional :ProducerPubkey, :string, 5
      repeated :Trxs, :message, 6, 'quorum.pb.Trx'
      optional :Sudo, :bool, 7
      optional :TimeStamp, :int64, 8
      optional :BlockHash, :bytes, 9
      optional :ProducerSign, :bytes, 10
    end
    add_message 'quorum.pb.ReqBlock' do
      optional :GroupId, :string, 1
      optional :FromBlock, :uint64, 2
      optional :BlksRequested, :int32, 3
      optional :ReqPubkey, :string, 4
    end
    add_message 'quorum.pb.BlocksBundle' do
      repeated :Blocks, :message, 1, 'quorum.pb.Block'
    end
    add_message 'quorum.pb.ReqBlockResp' do
      optional :GroupId, :string, 1
      optional :RequesterPubkey, :string, 2
      optional :ProviderPubkey, :string, 3
      optional :Result, :enum, 4, 'quorum.pb.ReqBlkResult'
      optional :FromBlock, :uint64, 5
      optional :BlksRequested, :int32, 6
      optional :BlksProvided, :int32, 7
      optional :Blocks, :message, 8, 'quorum.pb.BlocksBundle'
    end
    add_message 'quorum.pb.PostItem' do
      optional :TrxId, :string, 1
      optional :SenderPubkey, :string, 2
      optional :Content, :bytes, 3
      optional :TimeStamp, :int64, 4
    end
    add_message 'quorum.pb.ProducerItem' do
      optional :GroupId, :string, 1
      optional :ProducerPubkey, :string, 2
      optional :GroupOwnerPubkey, :string, 3
      optional :GroupOwnerSign, :string, 4
      optional :Action, :enum, 5, 'quorum.pb.ActionType'
      optional :WithnessBlocks, :int64, 6
      optional :TimeStamp, :int64, 7
      optional :Memo, :string, 8
    end
    add_message 'quorum.pb.BFTProducerBundleItem' do
      repeated :Producers, :message, 1, 'quorum.pb.ProducerItem'
    end
    add_message 'quorum.pb.UserItem' do
      optional :GroupId, :string, 1
      optional :UserPubkey, :string, 2
      optional :EncryptPubkey, :string, 3
      optional :GroupOwnerPubkey, :string, 4
      optional :GroupOwnerSign, :string, 5
      optional :TimeStamp, :int64, 6
      optional :Action, :enum, 7, 'quorum.pb.ActionType'
      optional :Memo, :string, 8
    end
    add_message 'quorum.pb.AnnounceItem' do
      optional :GroupId, :string, 1
      optional :SignPubkey, :string, 2
      optional :EncryptPubkey, :string, 3
      optional :AnnouncerSignature, :string, 4
      optional :Type, :enum, 5, 'quorum.pb.AnnounceType'
      optional :OwnerPubkey, :string, 6
      optional :OwnerSignature, :string, 7
      optional :Result, :enum, 8, 'quorum.pb.ApproveType'
      optional :TimeStamp, :int64, 9
      optional :Action, :enum, 10, 'quorum.pb.ActionType'
      optional :Memo, :string, 11
    end
    add_message 'quorum.pb.GroupItem' do
      optional :GroupId, :string, 1
      optional :GroupName, :string, 2
      optional :OwnerPubKey, :string, 3
      optional :UserSignPubkey, :string, 4
      optional :UserEncryptPubkey, :string, 5
      optional :LastUpdate, :int64, 6
      optional :GenesisBlock, :message, 7, 'quorum.pb.Block'
      optional :EncryptType, :enum, 8, 'quorum.pb.GroupEncryptType'
      optional :ConsenseType, :enum, 9, 'quorum.pb.GroupConsenseType'
      optional :CipherKey, :string, 10
      optional :AppKey, :string, 11
    end
    add_message 'quorum.pb.ChainConfigItem' do
      optional :GroupId, :string, 1
      optional :Type, :enum, 2, 'quorum.pb.ChainConfigType'
      optional :Data, :bytes, 3
      optional :OwnerPubkey, :string, 4
      optional :OwnerSignature, :string, 5
      optional :TimeStamp, :int64, 6
      optional :Memo, :string, 7
    end
    add_message 'quorum.pb.ChainSendTrxRuleListItem' do
      optional :Action, :enum, 1, 'quorum.pb.ActionType'
      optional :Pubkey, :string, 3
      repeated :Type, :enum, 4, 'quorum.pb.TrxType'
    end
    add_message 'quorum.pb.SetTrxAuthModeItem' do
      optional :Type, :enum, 1, 'quorum.pb.TrxType'
      optional :Mode, :enum, 2, 'quorum.pb.TrxAuthMode'
    end
    add_message 'quorum.pb.AppConfigItem' do
      optional :GroupId, :string, 1
      optional :Action, :enum, 2, 'quorum.pb.ActionType'
      optional :Name, :string, 3
      optional :Type, :enum, 4, 'quorum.pb.AppConfigType'
      optional :Value, :string, 5
      optional :OwnerPubkey, :string, 6
      optional :OwnerSign, :string, 7
      optional :Memo, :string, 8
      optional :TimeStamp, :int64, 9
    end
    add_message 'quorum.pb.GroupSeed' do
      optional :GenesisBlock, :message, 1, 'quorum.pb.Block'
      optional :GroupId, :string, 2
      optional :GroupName, :string, 3
      optional :OwnerPubkey, :string, 4
      optional :ConsensusType, :string, 5
      optional :EncryptionType, :string, 6
      optional :CipherKey, :string, 7
      optional :AppKey, :string, 8
      optional :Signature, :string, 9
    end
    add_message 'quorum.pb.NodeSDKGroupItem' do
      optional :Group, :message, 1, 'quorum.pb.GroupItem'
      optional :EncryptAlias, :string, 2
      optional :SignAlias, :string, 3
      repeated :ApiUrl, :string, 4
      optional :GroupSeed, :string, 5
    end
    add_message 'quorum.pb.HBTrxBundle' do
      repeated :Trxs, :message, 1, 'quorum.pb.Trx'
    end
    add_message 'quorum.pb.HBMsgv1' do
      optional :MsgId, :string, 1
      optional :Epoch, :uint64, 2
      optional :PayloadType, :enum, 3, 'quorum.pb.HBMsgPayloadType'
      optional :Payload, :bytes, 4
    end
    add_message 'quorum.pb.RBCMsg' do
      optional :Type, :enum, 1, 'quorum.pb.RBCMsgType'
      optional :Payload, :bytes, 2
    end
    add_message 'quorum.pb.InitPropose' do
      optional :RootHash, :bytes, 1
      repeated :Proof, :bytes, 2
      optional :Index, :int64, 3
      optional :Leaves, :int64, 4
      optional :OriginalDataSize, :int64, 5
      optional :RecvNodePubkey, :string, 6
      optional :ProposerPubkey, :string, 7
      optional :ProposerSign, :bytes, 8
    end
    add_message 'quorum.pb.Echo' do
      optional :RootHash, :bytes, 1
      repeated :Proof, :bytes, 2
      optional :Index, :int64, 3
      optional :Leaves, :int64, 4
      optional :OriginalDataSize, :int64, 5
      optional :OriginalProposerPubkey, :string, 6
      optional :EchoProviderPubkey, :string, 7
      optional :EchoProviderSign, :bytes, 8
    end
    add_message 'quorum.pb.Ready' do
      optional :RootHash, :bytes, 1
      optional :OriginalProposerPubkey, :string, 2
      optional :ReadyProviderPubkey, :string, 3
      optional :ReadyProviderSign, :bytes, 4
    end
    add_message 'quorum.pb.BBAMsg' do
      optional :Type, :enum, 1, 'quorum.pb.BBAMsgType'
      optional :Payload, :bytes, 2
    end
    add_message 'quorum.pb.Bval' do
      optional :ProposerId, :string, 1
      optional :SenderPubkey, :string, 2
      optional :Epoch, :int64, 3
      optional :Value, :bool, 4
    end
    add_message 'quorum.pb.Aux' do
      optional :ProposerId, :string, 1
      optional :SenderPubkey, :string, 2
      optional :Epoch, :uint64, 3
      optional :Value, :bool, 4
    end
    add_message 'quorum.pb.GroupItemV0' do
      optional :GroupId, :string, 1
      optional :GroupName, :string, 2
      optional :OwnerPubKey, :string, 3
      optional :UserSignPubkey, :string, 4
      optional :UserEncryptPubkey, :string, 5
      optional :UserRole, :enum, 6, 'quorum.pb.RoleV0'
      optional :LastUpdate, :int64, 7
      optional :HighestHeight, :int64, 8
      optional :HighestBlockId, :string, 9
      optional :GenesisBlock, :message, 10, 'quorum.pb.Block'
      optional :EncryptType, :enum, 11, 'quorum.pb.GroupEncryptType'
      optional :ConsenseType, :enum, 12, 'quorum.pb.GroupConsenseType'
      optional :CipherKey, :string, 13
      optional :AppKey, :string, 14
    end
    add_enum 'quorum.pb.PackageType' do
      value :TRX, 0
      value :BLOCK, 1
      value :HBB, 2
    end
    add_enum 'quorum.pb.AnnounceType' do
      value :AS_USER, 0
      value :AS_PRODUCER, 1
    end
    add_enum 'quorum.pb.ApproveType' do
      value :ANNOUNCED, 0
      value :APPROVED, 1
      value :REJECTED, 2
    end
    add_enum 'quorum.pb.ActionType' do
      value :ADD, 0
      value :REMOVE, 1
    end
    add_enum 'quorum.pb.TrxStroageType' do
      value :CHAIN, 0
      value :CACHE, 1
    end
    add_enum 'quorum.pb.TrxType' do
      value :POST, 0
      value :ANNOUNCE, 1
      value :PRODUCER, 2
      value :USER, 3
      value :REQ_BLOCK, 4
      value :REQ_BLOCK_RESP, 5
      value :CHAIN_CONFIG, 6
      value :APP_CONFIG, 7
    end
    add_enum 'quorum.pb.ReqBlkResult' do
      value :BLOCK_IN_RESP, 0
      value :BLOCK_IN_RESP_ON_TOP, 1
      value :BLOCK_NOT_FOUND, 2
    end
    add_enum 'quorum.pb.GroupEncryptType' do
      value :PUBLIC, 0
      value :PRIVATE, 1
    end
    add_enum 'quorum.pb.GroupConsenseType' do
      value :POA, 0
      value :POS, 1
    end
    add_enum 'quorum.pb.RoleV0' do
      value :GROUP_PRODUCER, 0
      value :GROUP_USER, 1
    end
    add_enum 'quorum.pb.ChainConfigType' do
      value :SET_TRX_AUTH_MODE, 0
      value :UPD_DNY_LIST, 1
      value :UPD_ALW_LIST, 2
    end
    add_enum 'quorum.pb.TrxAuthMode' do
      value :FOLLOW_ALW_LIST, 0
      value :FOLLOW_DNY_LIST, 1
    end
    add_enum 'quorum.pb.AuthListType' do
      value :ALLOW_LIST, 0
      value :DENY_LIST, 1
    end
    add_enum 'quorum.pb.AppConfigType' do
      value :INT, 0
      value :BOOL, 1
      value :STRING, 2
    end
    add_enum 'quorum.pb.HBMsgPayloadType' do
      value :RBC, 0
      value :BBA, 1
    end
    add_enum 'quorum.pb.RBCMsgType' do
      value :INIT_PROPOSE, 0
      value :ECHO, 1
      value :READY, 2
    end
    add_enum 'quorum.pb.BBAMsgType' do
      value :BVAL, 0
      value :AUX, 1
    end
  end
end

module Quorum
  module Pb
    Package = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Package').msgclass
    Trx = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Trx').msgclass
    Block = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Block').msgclass
    ReqBlock = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ReqBlock').msgclass
    BlocksBundle = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BlocksBundle').msgclass
    ReqBlockResp = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ReqBlockResp').msgclass
    PostItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.PostItem').msgclass
    ProducerItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ProducerItem').msgclass
    BFTProducerBundleItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BFTProducerBundleItem').msgclass
    UserItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.UserItem').msgclass
    AnnounceItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AnnounceItem').msgclass
    GroupItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupItem').msgclass
    ChainConfigItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ChainConfigItem').msgclass
    ChainSendTrxRuleListItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ChainSendTrxRuleListItem').msgclass
    SetTrxAuthModeItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.SetTrxAuthModeItem').msgclass
    AppConfigItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AppConfigItem').msgclass
    GroupSeed = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupSeed').msgclass
    NodeSDKGroupItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.NodeSDKGroupItem').msgclass
    HBTrxBundle = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.HBTrxBundle').msgclass
    HBMsgv1 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.HBMsgv1').msgclass
    RBCMsg = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.RBCMsg').msgclass
    InitPropose = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.InitPropose').msgclass
    Echo = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Echo').msgclass
    Ready = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Ready').msgclass
    BBAMsg = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BBAMsg').msgclass
    Bval = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Bval').msgclass
    Aux = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Aux').msgclass
    GroupItemV0 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupItemV0').msgclass
    PackageType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.PackageType').enummodule
    AnnounceType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AnnounceType').enummodule
    ApproveType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ApproveType').enummodule
    ActionType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ActionType').enummodule
    TrxStroageType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.TrxStroageType').enummodule
    TrxType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.TrxType').enummodule
    ReqBlkResult = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ReqBlkResult').enummodule
    GroupEncryptType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupEncryptType').enummodule
    GroupConsenseType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupConsenseType').enummodule
    RoleV0 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.RoleV0').enummodule
    ChainConfigType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ChainConfigType').enummodule
    TrxAuthMode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.TrxAuthMode').enummodule
    AuthListType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AuthListType').enummodule
    AppConfigType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AppConfigType').enummodule
    HBMsgPayloadType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.HBMsgPayloadType').enummodule
    RBCMsgType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.RBCMsgType').enummodule
    BBAMsgType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BBAMsgType').enummodule
  end
end
