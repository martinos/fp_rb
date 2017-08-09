# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fp_rb/version'

Gem::Specification.new do |spec|
  spec.name          = "fp_rb"
  spec.version       = FpRb::VERSION
  spec.authors       = ["Martin Chabot"]
  spec.email         = ["chabotm@gmail.com"]

  spec.summary       = %q{Collection of utilities for programming in a more functional way}
  spec.description   = %q{Collection of utilities for programming in a more functional way}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "superators19", "~>0.9.3"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
