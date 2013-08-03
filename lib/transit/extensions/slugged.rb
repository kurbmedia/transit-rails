module Transit
  module Extensions
    ##
    # Includes functionality for creating url slugs 
    # for deliverable models.
    # 
    module Slugged
      extend ActiveSupport::Concern
      
      included do
        before_save :auto_generate_slug
      end
      
      ##
      # Generate a slug via interpolation. 
      # Detect publishable models and skip generation 
      # unless the model is published.
      # 
      def auto_generate_slug
        return true unless self.slug.nil?
        return true if self.respond_to?(:published?) && !self.published?
        self.slug = self.interpolate_slug
      end
      
      ##
      # Takes the models interpolation string and 
      # generates a slug. By default this is simply :title
      # 
      def interpolate_slug
        interpolation = self.delivery_options.slugged
        ::Transit::Interpolations.interpolate(interpolation, self)
      end
    end
    
  end
end