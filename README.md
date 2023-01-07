# QuorumSdk

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add quorum_sdk

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install quorum_sdk

## Usage

### Send a trx

```ruby
# initilize SDK
rum = QuorumSdk::API.new "rum://...."

# build a message
msg = Quorum::Pb::Object.new(type: 'Note', name: 'A title', content: 'Something awesome.')

# prepare an ETH account
account = QuorumSdk::Account.new

# Or use a existed account
# account = QuorumSdk::Account.new priv: private_key

# build trx
trx = rum.build_trx data: msg, private_key: account.private_hex

# push trx to chain
rum.send_trx trx
# output: { trx_id: '...' }

```

Build a activity message

```ruby
# initilize SDK
rum = QuorumSdk::API.new "rum://...."

# build a Note type object
note = QuorumSdk::Object.new(type: 'Note', name: 'A title', content: 'Something awesome.')

# build Activity object, wrapping Note object
activity = Quorum::Pb::Activity.new(type: 'Create', object: note)

# build Trx
trx = rum.build_trx data: activity, private_key: account.private_hex

# push trx to chain
rum.send_trx trx
# output: { trx_id: '...' }

# list Trx on chain
rum.list_trx
# output: [{ trx_id: '...', Data: { type: 'Create', object: { type: 'Note', name: 'A title', content: 'Something awesome' }}}]

```

### Proto

Check all available proto types in [chain_pb.rb](./lib/proto/chain_pb.rb) and [activity_stream_pb.rb](./lib/proto/activity_stream_pb.rb).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/an-lee/quorum_sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/an-lee/quorum_sdk/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the QuorumSdk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/an-lee/quorum_sdk/blob/main/CODE_OF_CONDUCT.md).
