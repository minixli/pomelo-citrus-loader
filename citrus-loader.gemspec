# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 16 July 2014

$:.push File.expand_path('../lib', __FILE__)

require 'citrus-loader/version'

Gem::Specification.new do |spec|
  spec.name        = 'pomelo-citrus-loader'
  spec.version     = CitrusLoader::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['MinixLi']
  spec.email       = 'MinixLi1986@gmail.com'
  spec.description = %q{pomelo-citrus-loader is a simple clone of pomelo-loader}
  spec.summary     = %q{pomelo-loader clone written in Ruby using EventMachine}
  spec.homepage    = 'https://github.com/minixli/pomelo-citrus-loader'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
