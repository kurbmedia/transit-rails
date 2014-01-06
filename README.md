## Transit

Transit is a content management engine for Rails, built off of [Mercury Editor](https://github.com/jejacks0n/mercury). It is designed to be flexible and user friendly. 

* Works with either ActiveRecord and Mongoid
* Manage pages and page content
* Create and Manage menus for navigation, footers, etc.
* Support for Mercury functionality such as snippets and custom regions.
* Gives end-users a flexible solution for editing content, but without allowing them to clutter up pages or break existing design.

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

#### Assets
To get all of the CSS and javascripts for things like the menu and page editor, require them in your SCSS and JS files. A transit.js will be created for you which will allow you to set configuration options.

```javascript
//= require transit/frontend
```
```scss
@import 'transit/frontend'
```