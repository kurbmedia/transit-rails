source "https://rubygems.org"

gem 'rails', '3.2.16'

# Declare your gem's dependencies in transit.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'jquery-rails'
gem 'coffee-rails'
gem 'ejs'
gem 'sass-rails', '~> 3.2'
gem 'bootstrap-sass', "~> 3.1.0.2"
gem 'konacha', '~> 3.1.0'

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