$:.push File.expand_path('../lib', __FILE__)

require 'who_to_blame/version'

Gem::Specification.new do |spec|
  spec.name          = 'who_to_blame'
  spec.version       = WhoToBlame::VERSION
  spec.authors       = ['Holman Gao']
  spec.email         = ['holman@golmansax.com']
  spec.description   = ''
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = Dir['{app,config,lib}/**/*', 'LICENSE', 'README.md']
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(spec)\//)
  spec.require_paths = ['lib']
end
