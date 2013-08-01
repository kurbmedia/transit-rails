# Configure Rails Environment

ENV["RAILS_ENV"] = "test"
TRANSIT_ORM = (ENV["TRANSIT_ORM"] || "mongoid")


require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'


Rails.backtrace_cleaner.remove_silencers!

require 'simplecov'
SimpleCov.start 'rails'

require "machinist/#{TRANSIT_ORM}"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.mock_with :rspec
  config.extend ORMHelpers
  
  ##
  # Mongoid specific test functionality
  # 
  if TRANSIT_ORM == 'mongoid'
    config.include Mongoid::Matchers
    config.before(:each) do
      Mongoid.purge!
      Mongoid::IdentityMap.clear
    end
  end
  
  ##
  # AR specific test functionality
  # 
  if TRANSIT_ORM == 'active_record'
    config.use_transactional_fixtures = true
  end

end