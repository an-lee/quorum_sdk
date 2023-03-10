# frozen_string_literal: true

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: lib/proto/chain.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file('lib/proto/chain.proto', syntax: :proto3) do
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
      optional :Nonce, :int64, 9
      optional :SenderPubkey, :string, 10
      optional :SenderSign, :bytes, 11
      optional :StorageType, :enum, 12, 'quorum.pb.TrxStroageType'
    end
    add_message 'quorum.pb.Block' do
      optional :BlockId, :string, 1
      optional :GroupId, :string, 2
      optional :PrevBlockId, :string, 3
      optional :PreviousHash, :bytes, 4
      repeated :Trxs, :message, 5, 'quorum.pb.Trx'
      optional :ProducerPubKey, :string, 6
      optional :Hash, :bytes, 7
      optional :Signature, :bytes, 8
      optional :TimeStamp, :int64, 9
    end
    add_message 'quorum.pb.Snapshot' do
      optional :SnapshotId, :string, 1
      optional :SnapshotPackageId, :string, 2
      optional :TotalCount, :int64, 3
      optional :GroupId, :string, 4
      optional :Nonce, :int64, 5
      repeated :SnapshotItems, :message, 6, 'quorum.pb.SnapshotItem'
      optional :SenderPubkey, :string, 7
      optional :Singature, :bytes, 8
      optional :TimeStamp, :int64, 9
      optional :HighestHeight, :int64, 10
      optional :HighestBlockId, :string, 11
      optional :ItemsHash, :bytes, 12
    end
    add_message 'quorum.pb.SnapshotItem' do
      optional :SnapshotItemId, :string, 1
      optional :Type, :enum, 2, 'quorum.pb.SnapShotItemType'
      optional :Data, :bytes, 3
    end
    add_message 'quorum.pb.SnapShotTag' do
      optional :TimeStamp, :int64, 1
      optional :HighestHeight, :int64, 2
      optional :HighestBlockId, :string, 3
      optional :ItemsHash, :bytes, 4
      optional :Nonce, :int64, 5
      optional :SnapshotPackageId, :string, 6
      optional :SenderPubkey, :string, 7
    end
    add_message 'quorum.pb.BlockDbChunk' do
      optional :BlockId, :string, 1
      optional :BlockItem, :message, 2, 'quorum.pb.Block'
      optional :ParentBlockId, :string, 3
      repeated :SubBlockId, :string, 4
      optional :Height, :int64, 6
    end
    add_message 'quorum.pb.ReqBlock' do
      optional :BlockId, :string, 1
      optional :GroupId, :string, 2
      optional :UserId, :string, 3
    end
    add_message 'quorum.pb.BlockSynced' do
      optional :BlockItem, :message, 1, 'quorum.pb.Block'
    end
    add_message 'quorum.pb.AskPeerId' do
      optional :GroupId, :string, 1
      optional :UserPeerId, :string, 2
      optional :UserPubkey, :string, 3
      optional :UserSign, :string, 4
      optional :Memo, :string, 5
    end
    add_message 'quorum.pb.AskPeerIdResp' do
      optional :GroupId, :string, 1
      optional :RespPeerId, :string, 2
      optional :RespPeerPubkey, :string, 3
      optional :RespSign, :string, 4
      optional :IsDirectConnected, :bool, 5
    end
    add_message 'quorum.pb.BlockProduced' do
      optional :BlockItem, :message, 1, 'quorum.pb.Block'
    end
    add_message 'quorum.pb.ReqBlockResp' do
      optional :Result, :enum, 1, 'quorum.pb.ReqBlkResult'
      optional :ProviderPubkey, :string, 2
      optional :RequesterPubkey, :string, 3
      optional :GroupId, :string, 4
      optional :BlockId, :string, 5
      optional :Block, :bytes, 6
    end
    add_message 'quorum.pb.PostItem' do
      optional :TrxId, :string, 1
      optional :PublisherPubkey, :string, 2
      optional :Content, :bytes, 3
      optional :TimeStamp, :int64, 4
    end
    add_message 'quorum.pb.ProducerItem' do
      optional :GroupId, :string, 1
      optional :ProducerPubkey, :string, 2
      optional :GroupOwnerPubkey, :string, 3
      optional :GroupOwnerSign, :string, 4
      optional :TimeStamp, :int64, 5
      optional :Action, :enum, 6, 'quorum.pb.ActionType'
      optional :BlockProduced, :int64, 7
      optional :Memo, :string, 8
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
    add_message 'quorum.pb.SchemaItem' do
      optional :GroupId, :string, 1
      optional :GroupOwnerPubkey, :string, 2
      optional :GroupOwnerSign, :string, 3
      optional :Type, :string, 4
      optional :Rule, :string, 5
      optional :TimeStamp, :int64, 6
      optional :Action, :enum, 7, 'quorum.pb.ActionType'
    end
    add_message 'quorum.pb.GroupItem' do
      optional :GroupId, :string, 1
      optional :GroupName, :string, 2
      optional :OwnerPubKey, :string, 3
      optional :UserSignPubkey, :string, 4
      optional :UserEncryptPubkey, :string, 5
      optional :LastUpdate, :int64, 6
      optional :HighestHeight, :int64, 7
      optional :HighestBlockId, :string, 8
      optional :GenesisBlock, :message, 9, 'quorum.pb.Block'
      optional :EncryptType, :enum, 10, 'quorum.pb.GroupEncryptType'
      optional :ConsenseType, :enum, 11, 'quorum.pb.GroupConsenseType'
      optional :CipherKey, :string, 12
      optional :AppKey, :string, 13
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
    add_message 'quorum.pb.PSPing' do
      optional :Seqnum, :int32, 1
      optional :IsResp, :bool, 2
      optional :TimeStamp, :int64, 3
      optional :Payload, :bytes, 4
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
    add_message 'quorum.pb.HBMsg' do
      optional :MsgId, :string, 1
      optional :MsgType, :enum, 2, 'quorum.pb.HBBMsgType'
      optional :Payload, :bytes, 3
    end
    add_message 'quorum.pb.HBTrxBundle' do
      repeated :Trxs, :message, 1, 'quorum.pb.Trx'
    end
    add_message 'quorum.pb.BroadcastMsg' do
      optional :SenderPubkey, :string, 1
      optional :Type, :enum, 2, 'quorum.pb.BroadcastMsgType'
      optional :Epoch, :int64, 3
      optional :Payload, :bytes, 4
    end
    add_message 'quorum.pb.Proof' do
      optional :RootHash, :bytes, 1
      repeated :Proof, :bytes, 2
      optional :Index, :int64, 3
      optional :Leaves, :int64, 4
      optional :ProposerPubkey, :bytes, 5
      optional :ProposerSign, :bytes, 6
    end
    add_message 'quorum.pb.Ready' do
      optional :RootHash, :bytes, 1
      optional :ProoferPubkey, :bytes, 2
      optional :ProposerPubkey, :bytes, 3
      optional :ProposerSign, :bytes, 4
    end
    add_message 'quorum.pb.AgreementMsg' do
      optional :Type, :enum, 1, 'quorum.pb.AgreementMsgType'
      optional :ProposerId, :string, 2
      optional :SenderId, :string, 3
      optional :Epoch, :int64, 4
      optional :Payload, :bytes, 5
    end
    add_message 'quorum.pb.Bval' do
      optional :Value, :bool, 1
    end
    add_message 'quorum.pb.Aux' do
      optional :Value, :bool, 1
    end
    add_enum 'quorum.pb.PackageType' do
      value :TRX, 0
      value :BLOCK, 1
      value :SNAPSHOT, 2
      value :HBB, 3
    end
    add_enum 'quorum.pb.TrxType' do
      value :POST, 0
      value :SCHEMA, 2
      value :PRODUCER, 3
      value :ANNOUNCE, 4
      value :REQ_BLOCK_FORWARD, 5
      value :REQ_BLOCK_BACKWARD, 6
      value :REQ_BLOCK_RESP, 7
      value :BLOCK_SYNCED, 8
      value :BLOCK_PRODUCED, 9
      value :USER, 10
      value :ASK_PEERID, 11
      value :ASK_PEERID_RESP, 12
      value :CHAIN_CONFIG, 13
      value :APP_CONFIG, 14
    end
    add_enum 'quorum.pb.AnnounceType' do
      value :AS_USER, 0
      value :AS_PRODUCER, 1
      value :AS_USER_ENCRYPT, 2
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
    add_enum 'quorum.pb.SnapShotItemType' do
      value :SNAPSHOT_APP_CONFIG, 0
      value :SNAPSHOT_CHAIN_CONFIG, 1
      value :SNAPSHOT_PRODUCER, 2
      value :SNAPSHOT_USER, 3
      value :SNAPSHOT_ANNOUNCE, 4
    end
    add_enum 'quorum.pb.ReqBlkResult' do
      value :BLOCK_IN_TRX, 0
      value :BLOCK_NOT_FOUND, 1
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
    add_enum 'quorum.pb.HBBMsgType' do
      value :AGREEMENT, 0
      value :BROADCAST, 1
    end
    add_enum 'quorum.pb.BroadcastMsgType' do
      value :PROOF, 0
      value :READY, 1
    end
    add_enum 'quorum.pb.AgreementMsgType' do
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
    Snapshot = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Snapshot').msgclass
    SnapshotItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.SnapshotItem').msgclass
    SnapShotTag = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.SnapShotTag').msgclass
    BlockDbChunk = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BlockDbChunk').msgclass
    ReqBlock = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ReqBlock').msgclass
    BlockSynced = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BlockSynced').msgclass
    AskPeerId = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AskPeerId').msgclass
    AskPeerIdResp = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AskPeerIdResp').msgclass
    BlockProduced = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BlockProduced').msgclass
    ReqBlockResp = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ReqBlockResp').msgclass
    PostItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.PostItem').msgclass
    ProducerItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ProducerItem').msgclass
    UserItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.UserItem').msgclass
    AnnounceItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AnnounceItem').msgclass
    SchemaItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.SchemaItem').msgclass
    GroupItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupItem').msgclass
    ChainConfigItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ChainConfigItem').msgclass
    ChainSendTrxRuleListItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ChainSendTrxRuleListItem').msgclass
    SetTrxAuthModeItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.SetTrxAuthModeItem').msgclass
    GroupItemV0 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupItemV0').msgclass
    AppConfigItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AppConfigItem').msgclass
    PSPing = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.PSPing').msgclass
    GroupSeed = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupSeed').msgclass
    NodeSDKGroupItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.NodeSDKGroupItem').msgclass
    HBMsg = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.HBMsg').msgclass
    HBTrxBundle = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.HBTrxBundle').msgclass
    BroadcastMsg = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BroadcastMsg').msgclass
    Proof = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Proof').msgclass
    Ready = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Ready').msgclass
    AgreementMsg = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AgreementMsg').msgclass
    Bval = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Bval').msgclass
    Aux = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.Aux').msgclass
    PackageType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.PackageType').enummodule
    TrxType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.TrxType').enummodule
    AnnounceType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AnnounceType').enummodule
    ApproveType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ApproveType').enummodule
    ActionType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ActionType').enummodule
    TrxStroageType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.TrxStroageType').enummodule
    SnapShotItemType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.SnapShotItemType').enummodule
    ReqBlkResult = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ReqBlkResult').enummodule
    GroupEncryptType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupEncryptType').enummodule
    GroupConsenseType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.GroupConsenseType').enummodule
    RoleV0 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.RoleV0').enummodule
    ChainConfigType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.ChainConfigType').enummodule
    TrxAuthMode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.TrxAuthMode').enummodule
    AuthListType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AuthListType').enummodule
    AppConfigType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AppConfigType').enummodule
    HBBMsgType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.HBBMsgType').enummodule
    BroadcastMsgType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.BroadcastMsgType').enummodule
    AgreementMsgType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup('quorum.pb.AgreementMsgType').enummodule
  end
end
