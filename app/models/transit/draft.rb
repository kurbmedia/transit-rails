require_dependency "transit/schemas/#{Transit.orm.to_s}/draft"

module Transit
  class Draft
    belongs_to :draftable, polymorphic: true
    
    
    ##
    # Read a property from the draft
    # 
    def read_property(name)
      content_hash[name]
    end
    
    
    ##
    # Write a property to the draft
    # 
    def write_property(name, value)
      content_hash[name] = value
    end
    
    
    private
    
    ##
    # Auto-create the content hash if it doesn't exist.
    # 
    def content_hash
      self.content ||= ActiveSupport::HashWithIndifferentAccess.new
    end
  end
end