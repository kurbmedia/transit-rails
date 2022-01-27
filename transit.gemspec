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
  s.summary     = %q{Transit is a content management engine for Rails 3.1+}
  s.description = %q{Transit is a content management engine for Rails 3.1+}

  s.rubyforge_project = "transit"
  s.license           = 'MIT'
  s.files             = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files        = Dir["test/**/*"]
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = ["lib"]

  s.add_dependency("rails", ">= 5", "< 8")
  s.add_dependency("ancestry", "~> 4.0")
  
  s.add_development_dependency("rspec", "~> 3.0")
  s.add_development_dependency("rspec-rails", "~> 5.0")
  s.add_development_dependency("factory_bot_rails", "~> 6.0")
  s.add_development_dependency("shoulda-matchers", "~> 5.0")

  s.add_development_dependency("pg", "~> 1.0")
end
