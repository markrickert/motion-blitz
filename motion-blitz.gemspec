# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name          = 'motion-blitz'
  spec.version       = '1.2.0'
  spec.authors       = ['Devon Blandin']
  spec.email         = 'dblandin@gmail.com'
  spec.description   = %q{RubyMotion wrapper for SVProgressHUD}
  spec.summary       = %q{RubyMotion wrapper for SVProgressHUD}
  spec.homepage      = 'http://github.com/dblandin/motion-blitz'
  spec.license       = 'MIT'

  files = []
  files << 'README.md'
  files << Dir.glob('lib/**/*.rb')
  spec.files         = files
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  
  spec.add_dependency 'motion-cocoapods', '>= 1.4.0'
  spec.add_development_dependency 'rake'
end
