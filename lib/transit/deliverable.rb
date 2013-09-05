module Transit
  ##
  # The base functionality for all deliverable models. 
  # This functionality can be added on models using deliverable types ( Pages / Posts )
  # or included within any class/model to provide access to extensions.
  # 
  module Deliverable
    extend ActiveSupport::Concern
    
    included do
      ##
      # Track any options passed to deliver_as, or assigned via extensions.
      # 
      class_attribute :delivery_options
      self.delivery_options ||= Transit::DeliveryOptions.new(:translate => Transit.config.translate, :slugged => Transit.config.slug_posts_via)
    end
    
    module ClassMethods
      
      ##
      # Adds support for adding extensions to models.
      # 
      def delivery_as(*args)
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
        
      end
    end
  end
end