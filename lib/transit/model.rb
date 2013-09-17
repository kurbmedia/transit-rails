module Transit
  
  ##
  # Raised when trying to include deliverable definition 
  # that does not exist.
  #
  class MissingExtensionError < Transit::Error
  end
  
  module Model
    
    ##
    # Included into any model using the 'transit' method.
    # Sets up some default options.
    # 
    module Delivery
      extend ActiveSupport::Concern
    
      included do
        ##
        # Track any options passed to deliver_as, or assigned via extensions.
        # 
        class_attribute :delivery_options
        self.delivery_options ||= Transit::DeliveryOptions.new(:translate => Transit.config.translate, :slugged => Transit.config.slug_posts_via)
      
        ##
        # Track whether or not we want to translate page attributes ( only Mongoid for now )
        # 
        class_attribute :has_translation_support
        self.has_translation_support = !!self.delivery_options.translate
      end
    end
    
    ##
    # Configures attributes and deliverable specific methods for the 
    # calling model. 
    #
    # @param [Symbol,String] type The type of deliverable. Each deliverable type is specified as a Transit::Definition
    # @param [Hash] options Any deliverable specific options
    # 
    def transit(type, *args)
      
      include Delivery
      
      options = args.extract_options! || {}
      options.symbolize_keys!

      self.delivery_options.merge!(options)
    
      ##
      # Take any additional options passed to deliver_as and 
      # attempt to include them as extensions.
      # 
      [options.keys, args].flatten.uniq.each do |ext|
        next if [:translate].include?(ext)
        mod_name = ext.to_s.classify
        if Transit::Extensions.const_defined?(mod_name)
          include Transit::Extensions.const_get(mod_name)
        end
      end
    
      unless Transit::Extensions.const_defined?(mdef)
        raise Transit::MissingExtensionError
      end
    
      include Transit::Extensions.const_get(mdef)
    end
  end
end