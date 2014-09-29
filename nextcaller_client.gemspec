# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nextcaller_client/version'

Gem::Specification.new do |s|
  s.name          = "nextcaller_client"
  s.version       = NextcallerClient::VERSION
  s.authors       = ["Dmitry Vlasov"]
  s.email         = ["d.vlasov.work@gmail.com"]
  s.summary       = 'A Ruby wrapper around the Nextcaller API.'
  s.description   = 'A Ruby wrapper around the Nextcaller API. See ttps://dev.nextcaller.com/documentation/ for details.'
  s.homepage      = 'http://rubygems.org/gems/nextcaller_client'
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"

  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'webmock'

  s.required_ruby_version = '>= 1.8.6'
end
