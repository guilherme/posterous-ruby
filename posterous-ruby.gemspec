# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "posterous-ruby/version"

Gem::Specification.new do |s|
  s.name        = "posterous-ruby"
  s.version     = Posterous::Ruby::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guilherme Reis Campos"]
  s.email       = ["guilhermekbsa@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/posterous-ruby"
  s.summary     = %q{posterous-ruby it's a ruby gem that implements the posterous(http://posterous.com) API 2.0}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "posterous-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec", "~> 2.0.1"
end
