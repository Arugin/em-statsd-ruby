# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'em/version'

Gem::Specification.new do |gem|
  gem.name        = 'em-statsd-ruby'
  gem.version     = EventMachine::Statsd::VERSION
  gem.homepage    = 'https://github.com/Arugin/em-statsd-ruby'

  gem.author      = 'Valery Mayatsky'
  gem.email       = 'valerymayatsky@gmail.com'
  gem.description = 'An Event Machine wrapper around Ruby Statsd client.'
  gem.summary     = 'An Event Machine wrapper around Ruby Statsd client.'

  gem.add_dependency 'eventmachine', '>= 1.2.0'
  gem.add_development_dependency 'bundler', '~> 1.0'

  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.require_paths = ['lib']
end