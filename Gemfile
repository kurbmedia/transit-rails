source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 6'

# Declare your gem's dependencies in transit.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec
gem "pg"

group :test do
  gem 'simplecov', :require => false
  gem 'rake'
  gem 'guard'
  gem "guard-rspec"
  gem 'rb-fsevent'
  gem 'listen'
  gem 'rspec', '~> 3.10'
  gem 'rspec-rails', '~> 5.0'
  gem 'factory_bot_rails'
end

group :doc do
  gem 'yard', '~> 0.9'
end