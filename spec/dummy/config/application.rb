require File.expand_path('../boot', __FILE__)

unless ENV['RAILS_ENV'].eql?('development')
  require 'sprockets/railtie'
  require "action_controller/railtie"
  require "action_mailer/railtie"
  require "active_resource/railtie"
  require 'active_record/railtie'
  require 'action_view/railtie'
  require "transit"
else
  require "action_controller/railtie"
  require "action_mailer/railtie"
  require "sprockets/railtie"
  require_relative 'initializers/konacha'
end

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.enabled = true
    config.autoload_paths.reject!{ |p| p =~ /\/app\/(\w+)$/ && !%w(controllers helpers mailers views).include?($1) }
    config.autoload_paths += [ "#{config.root}/app/#{TRANSIT_ORM}" ]
    
    config.assets.paths << File.join(Transit::Engine.config.root, Konacha.config.spec_dir)
    config.assets.paths << File.join(Transit::Engine.config.root, "spec/support/javascripts")
    
    puts Rails.application.assets.inspect
  end
end

