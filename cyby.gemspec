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
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "httparty", "~> 0.13.1"
  spec.add_runtime_dependency "activesupport", "~> 4.0.4"
end
