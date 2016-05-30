# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-unique-filter"
  spec.version       = '0.1.0'
  spec.authors       = ["HORII Keima"]
  spec.email         = ["holysugar@gmail.com"]

  spec.summary       = %q{Fluent unique filter plugin}
  spec.description   = %q{Fluent unique filter plugin thins messages with same value in a key}
  spec.homepage      = "https://github.com/holysugar/fluent-plugin-unique-filter"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fluentd", ">= 0.12.2"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.1.4"
end
