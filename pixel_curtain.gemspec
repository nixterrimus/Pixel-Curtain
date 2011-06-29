# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pixel_curtain/version"

Gem::Specification.new do |s|
  s.name        = "pixel_curtain"
  s.version     = PixelCurtain::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nick Rowe"]
  s.email       = ["nixterrimus@dcxn.com"]
  s.homepage    = "http://pixelcurtain.com"
  s.summary     = %q{Generate beautiful backgrounds from images}
  s.description = %q{Generate beautiful backgrounds from images}

  s.rubyforge_project = "pixel_curtain"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
