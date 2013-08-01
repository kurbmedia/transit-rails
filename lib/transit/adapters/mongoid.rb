require 'mongoid'
require 'mongoid-ancestry'
require 'transit/adapter'

module Transit
  module Adapter
    ##
    # Create a field for the model, optionally 
    # auto-adding translation support.
    # 
    # @param [Symbol] name The field name
    # @param [Object] type The class used as the type.
    # @param [Hash] options Options to be set on the field.
    # 
    def transit_attribute(name, type, options = {})
      options.reverse_merge!(:localize => self.has_translation_support) if options.has_key?(:localize)
      field name, { :type => type }.merge(options)
    end
    
    ##
    # Loads the ancestry gem and applies any passed options.
    # 
    # @param [Hash] options Options to be passed to the has_ancestry method
    # 
    def transit_ancestry(options = {})
      include Mongoid::Ancestry
      has_ancestry(options)
    end
  end
end

# autoload
Transit::Extensions::Published

module Transit
  module Extensions
    module Published
      module ClassMethods
        
        ##
        # Override here to use mongo specific queries
        # TODO: Maybe use orm_adapter or some kind of adapter functionality for this?
        #
        def published_by_date
          all_of(:published => true, :publish_date.gte => Date.today.to_time)
        end
      end
    end
  end
end

Mongoid::Document::ClassMethods.send(:include, Transit::Adapter)
Mongoid::Document::ClassMethods.send(:include, Transit::Models)