source "https://rubygems.org"

# Declare your gem's dependencies in transit.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :test do
  gem 'mongoid-rspec', '~> 1.8', :require => 'mongoid-rspec'
  gem 'simplecov', :require => false
  gem 'rake'
  gem 'guard'
  gem "guard-rspec"
  gem 'rb-fsevent'
  gem 'listen'
  gem 'machinist_mongo', github: 'brentkirby/machinist_mongo', require: 'machinist/mongoid'
  gem 'shoulda-matchers', '~> 2.2.0'
end

group :doc do
  gem 'yard', '0.8.5.2'
end