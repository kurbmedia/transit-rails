module Transit
  module Models
    ##
    # Common functionality to both post types.
    # 
    module Base
      extend ActiveSupport::Concern
      
      included do
        class_attribute :delivery_type
      end
      
      ##
      # Populate content schemas
      # 
      def content_schema=(hash)
        write_attribute(:content_schema, Transit::Schematic.new(hash))
      end
      
      ##
      # Support nested attributes
      # 
      def content_schema_attributes=(hash)
        content_schema = hash
      end
      
      ##
      # Convert the schematic to an array of objects 
      # for use in nested forms.
      # 
      def content_schema_attributes
        content_schema.to_list
      end
      
      ##
      # Used to set keywords via comma separated string
      # 
      def keyword_list=(words)
        self.keywords = words.split(",").compact.map!(&:strip)
      end
    
      ##
      # Display keywords as a comma separated string.
      # 
      def keyword_list
        [self.keywords].flatten.compact.join(",")
      end
      
      private
      
      ##
      # Generate the content attribute from the schematic
      # 
      def generate_content_from_schema
        self.content = self.content_schema.to_s
      end
    end
  end
end