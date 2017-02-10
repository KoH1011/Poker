# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "hurley"
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rick Olson", "Wynn Netherland", "Ben Maraney", "Kevin Kirsche"]
  s.date = "2015-09-05"
  s.description = "Hurley provides a common interface for working with different HTTP adapters."
  s.email = ["technoweenie@gmail.com", "kev.kirsche@gmail.com"]
  s.homepage = "https://github.com/lostisland/hurley"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14.1"
  s.summary = "HTTP client wrapper"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0"])
  end
end
