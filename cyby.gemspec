# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cyby/version'

Gem::Specification.new do |spec|
  spec.name          = "cyby"
  spec.version       = Cyby::VERSION
  spec.authors       = ["Hiroyuki Sato"]
  spec.email         = ["hiroyuki_sato@spiber.jp"]
  spec.description   = %q(Cybozu API wrapper)
  spec.summary       = %q(Cybozu API wrapper)
  spec.homepage      = "https://github.com/hiroponz/cyby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "2.3.18"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "httparty", "~> 0.20.0"
  spec.add_runtime_dependency "activesupport", "6.1.5"
end
