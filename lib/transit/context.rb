module Transit
  ##
  # Placeholder class for field types
  # 
  class Context
    attr_accessor :type, :id, :content, :node, :position, :properties
    
    class << self
      
      ##
      # List available context types.  
      # These are mostly suggestions, but any included assets etc honor them.
      # 
      def types
        ['HeadingText', 'TextBlock', 'Audio', 'Video']
      end
    end
    
    SELF_CLOSING_TAGS = ["img"]
    
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
      props = properties || {}
      html  = props.collect{ |key, value| '%s="%s"' % [key, value] }
      attrs = "" 
      attrs = (" " << html.join(" ")) unless html.empty?
      
      if SELF_CLOSING_TAGS.include?(node)
        return "" unless attrs.strip.blank?
        "<%s%s />" % [node, attrs]
      else
        "<%s%s>%s</%s>" % [node, attrs, content, node]
      end
    end
  end
end