require 'mongoid'

begin
  require 'mongoid-ancestry'
rescue Exception => e
  puts "\n\nPlease add the mongoid-ancestry gem to your Gemfile. "
  puts "  gem 'mongoid-ancestry'\n\n"
end

require 'transit/adapter'

Transit.orm = :mongoid

# autoload
Transit::Extensions::Publishable

module Transit
  module Extensions
    module Publishable
      module ClassMethods
        
        ##
        # Override here to use mongo specific queries
        # TODO: Maybe use orm_adapter or some kind of adapter functionality for this?
        #
        def published_by_date
          all_of(:published => true, :publish_date.lte => Date.today.to_time)
        end
      end
    end
  end
end

Mongoid::Document::ClassMethods.send(:include, Transit::Adapter)
Mongoid::Document::ClassMethods.send(:include, Transit::Model)