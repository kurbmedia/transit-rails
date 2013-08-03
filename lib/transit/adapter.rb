module Transit
  module Adapter
    mattr_accessor :serialize_fields
    @@serialize_fields = false
    
    ##
    # ORM adapters should overide this method to 
    # apply schemas to a model.
    # 
    def transit_attribute(scope, name, type, options = {})
      raise Transit::Adapter::MissingImplementationError
    end
    
    ##
    # Load the necessary gem/library for creating 
    # ancestries / trees.
    # 
    def transit_ancestry
      raise Transit::Adapter::MissingImplementationError
    end
    
    
    class MissingImplementationError < NotImplementedError
    end
  end
end