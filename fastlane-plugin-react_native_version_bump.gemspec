lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/react_native_version_bump/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-react_native_version_bump'
  spec.version       = Fastlane::ReactNativeVersionBump::VERSION
  spec.author        = 'Flix'
  spec.email         = 'flixy121@gmail.com'

  spec.summary       = 'Auto bump version for React Native projects'
  spec.homepage      = "https://github.com/flixyudh/fastlane-plugin-react_native_version_bump"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.6'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'
end
