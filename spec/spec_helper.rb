# Configure Rails Environment

ENV["RAILS_ENV"] = "test"
ENV["TRANSIT_ORM"] ||= "mongoid"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

Rails.backtrace_cleaner.remove_silencers!

require 'simplecov'
SimpleCov.start 'rails'

if ENV['TRANSIT_ORM'] == 'mongoid'
  require 'mongoid'
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.mock_with :rspec
  
  ##
  # Mongoid specific test functionality
  # 
  if ENV['TRANSIT_ORM'] == 'mongoid'
    config.before(:each) do
      Mongoid.purge!
      Mongoid::IdentityMap.clear
    end
  end

end