# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autobank/version'

Gem::Specification.new do |spec|
  spec.name          = "autobank"
  spec.version       = Autobank::VERSION
  spec.authors       = ["Ryan Kowalick"]
  spec.email         = ["rkowalick@gmail.com"]
  spec.description   = %q{Autobank automates generation of Ledger CLI entries from Chase online banking}
  spec.summary       = %q{Generates Ledger CLI entries from Chase online banking}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "mechanize"
end
