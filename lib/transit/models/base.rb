module Transit
  module Models
    ##
    # Common functionality to both post types.
    # 
    module Base
      extend ActiveSupport::Concern
      
      included do
        class_attribute :delivery_type

        ##
        # Track any options passed to deliver_as for use within 
        # core modules or extensions.
        # 
        class_attribute :delivery_options
        self.delivery_options ||= Transit::DeliveryOptions.new(:translate => Transit.config.translate)
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
    end
  end
end