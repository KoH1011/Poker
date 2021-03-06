# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "word_wrap"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Radek Pazdera"]
  s.date = "2015-04-21"
  s.description = "As simple as it gets CLI tool for word-wrapping\n                          plain-text. You can also use the library in your\n                          Ruby scripts. Check out the sources for details."
  s.email = ["radek@pazdera.co.uk"]
  s.executables = ["ww"]
  s.files = ["bin/ww"]
  s.homepage = "https://github.com/pazdera/word_wrap"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14.1"
  s.summary = "Simple tool for word-wrapping text"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, ["~> 0"])
      s.add_development_dependency(%q<rspec>, ["~> 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, ["~> 0"])
      s.add_dependency(%q<rspec>, ["~> 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, ["~> 0"])
    s.add_dependency(%q<rspec>, ["~> 0"])
  end
end
