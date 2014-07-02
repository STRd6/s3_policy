# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3_policy/version'

Gem::Specification.new do |spec|
  spec.name          = "s3_policy"
  spec.version       = S3Policy::VERSION
  spec.authors       = ["Daniel X Moore"]
  spec.email         = ["yahivin@gmail.com"]
  spec.description   = %q{S3 Policy Document Generator}
  spec.summary       = %q{Generate a signed S3 policy document for namespaced clientside uploads.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
