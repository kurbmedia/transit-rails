## Transit

Transit is a content management engine for Rails, designed to work with the Transit js library.

* Manage pages and page content
* Create and Manage menus for navigation, footers, etc.

### Installation

Add it to your gemfile:
```ruby
gem 'transit', github: 'kurbmedia/transit-rails'
```
Then run the install generator.
```text
bundle exec rails g transit:install
```
Once installed, mount the engine in your routes file.
```ruby
mount Transit::Engine => "/transit"
```