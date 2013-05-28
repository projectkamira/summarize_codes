# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'summarize_codes/version'

Gem::Specification.new do |spec|
  spec.name          = "summarize_codes"
  spec.version       = SummarizeCodes::VERSION
  spec.authors       = ["Marc Hadley"]
  spec.email         = ["mhadley@mitre.org"]
  spec.description   = %q{Convert a spreadsheet of code counts into the JSON format expected by the analyze_codes script}
  spec.summary       = %q{Convert a spreadsheet of code counts into the JSON format expected by the analyze_codes script}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
#  spec.add_dependency 'health-data-standards', '3.1.1'
  
end
