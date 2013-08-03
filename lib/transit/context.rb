module Transit
  ##
  # Placeholder class for field types
  # 
  class Context
    attr_accessor :type, :id, :content, :node, :position, :properties
    
    ##
    # Create a field from a hash.
    # 
    def initialize(data = {})
      data.each do |key, value|
        self.send(:"#{key.to_s}=", value)
      end
    end
    
    ##
    # Does this field require a wrapping node?
    # 
    def node?
      node.present?
    end
    
    ##
    # Generate output for this context
    # 
    def to_s
      return content unless node?
      "<%s>%s</%s>" % [node, content, node]
    end
  end
end