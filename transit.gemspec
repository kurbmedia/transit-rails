$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "transit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "transit"
  s.version     = Transit::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["dev@kurbmedia.com"]
  s.homepage    = "https://github.com/kurbmedia/transit-rails"
  s.summary     = %q{Transit is a content management engine for Rails 3.1+ based on Mercury editor.}
  s.description = %q{Transit is a content management engine for Rails 3.1+ based on Mercury editor. It supports ActiveRecord, as well as Mongoid}

  s.rubyforge_project = "transit"
  s.license           = 'MIT'
  s.files             = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files        = Dir["test/**/*"]
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = ["lib"]

  s.add_dependency("rails", ">= 3.2.6", "< 5")
  s.add_dependency("bootstrap-sass", "~> 3.1")
  
  s.add_development_dependency("rspec", ">= 2.14.0")
  s.add_development_dependency("rspec-rails", ">= 2.14.0")
  s.add_development_dependency("machinist", "~> 2.0")
  
  s.add_development_dependency("mysql2", "~> 0.3.11")
  s.add_development_dependency("mongoid", ">= 3.1")
  s.add_development_dependency("mongoid-rspec", "~> 1.8")
end
