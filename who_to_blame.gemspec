# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'who_to_blame/version'
require 'English'

Gem::Specification.new do |spec|
  spec.name          = 'who-to-blame'
  spec.version       = WhoToBlame::VERSION
  spec.authors       = ['Holman Gao']
  spec.email         = ['holman@golmansax.com']
  spec.description   = ''
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(spec)\//)
  spec.require_paths = ['lib']
end
