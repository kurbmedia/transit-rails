require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "transit"

module Dummy
  class Application < Rails::Application
    
    config.autoload_paths.reject!{ |p| p =~ /\/app\/(\w+)$/ && !%w(controllers helpers mailers views).include?($1) }
    config.autoload_paths += [ "#{config.root}/app/#{TRANSIT_ORM}" ]
  end
end

