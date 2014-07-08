$LOAD_PATH.push File.expand_path('../lib', __FILE__)

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

  spec.files         = Dir['{app,bin,config,lib}/**/*', 'LICENSE', 'README.md']
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'react-rails'
  spec.add_runtime_dependency 'rails-assets-react'
  spec.add_runtime_dependency 'rails-assets-reqwest'

  spec.add_development_dependency 'protected_attributes'
  spec.add_development_dependency 'sqlite3'
end
