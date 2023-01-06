# frozen_string_literal: true

require_relative 'lib/quorum_sdk/version'

Gem::Specification.new do |spec|
  spec.name = 'quorum_sdk'
  spec.version = QuorumSdk::VERSION
  spec.authors = ['an-lee']
  spec.email = ['an.lee.work@gmail.com']

  spec.summary = 'A Quorum SDK implemented in Ruby'
  spec.description = 'A API wrapper for Quorum'
  spec.homepage = 'https://github.com/an-lee/quorum_sdk'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['allowed_push_host'] = ''

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/an-lee/quorum_sdk'
  spec.metadata['changelog_uri'] = 'https://github.com/an-lee/quorum_sdk/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'activesupport', '>= 5'
  spec.add_dependency 'addressable', '~> 2'
  spec.add_dependency 'bcrypt', '~> 3.1'
  spec.add_dependency 'eth', '~> 0.5'
  spec.add_dependency 'faraday', '>= 2'
  spec.add_dependency 'faraday-retry', '>= 2'
  spec.add_dependency 'google-protobuf', '~> 3'
  spec.add_dependency 'sha3', '~> 1.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
