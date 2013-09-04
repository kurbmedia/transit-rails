module Transit
  
  ##
  # Raised when trying to include deliverable definition 
  # that does not exist.
  #
  class MissingDefinitionError < Transit::Error
  end
  
  module Models
    
    autoload :Base, "transit/models/base"
    autoload :Post, "transit/models/post"
    autoload :Page, "transit/models/page"
    
    ##
    # Configures attributes and deliverable specific methods for the 
    # calling model. 
    #
    # @param [Symbol,String] type The type of deliverable. Each deliverable type is specified as a Transit::Definition
    # @param [Hash] options Any deliverable specific options
    # 
    def deliver_as(type, *args)
      include Transit::Deliverable
      include Transit::Models::Base
      
      deliver_with(*args)
      
      ##
      # Track whether or not this model should be translated.
      # 
      class_attribute :has_translation_support
      self.has_translation_support = !!self.delivery_options.translate
      
      ##
      # Register the deliverable.
      # 
      self.delivery_type = type
      Transit.add_deliverable(self, type)
      
      mdef = type.to_s.classify
      
      unless Transit::Models.const_defined?(mdef)
        raise Transit::MissingDefinitionError
      end
      
      include Transit::Models.const_get(mdef)
    end
    
    
    ##
    # Allow updating delivery options within a model by passing it a block
    # 
    def modify_delivery
      return unless block_given?
      yield self.delivery_options
    end
  end
end