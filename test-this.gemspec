# coding: utf-8

lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'test/this/version'

Gem::Specification.new do |spec|
  spec.name = 'test-this'
  spec.version = Test::This::VERSION
  spec.authors = ['Travis Haynes']
  spec.email = ['travis@hi5dev.com']

  spec.summary = 'Use Rake to run one test in a class.'
  spec.homepage = 'https://github.com/hi5dev/test-this'
  spec.license = 'MIT'

  spec.bindir = 'exe'
  spec.require_paths = %w[lib]

  spec.files = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end

  spec.executables = spec.files.grep(%r{^#{spec.bindir}/}) do |file|
    File.basename(file)
  end

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
