module Transit
  module Extensions
    ##
    # Includes functionality for creating url slugs 
    # for deliverable models.
    # 
    module Sluggable
      extend ActiveSupport::Concern
      
      included do
        before_validation :auto_generate_slug
      end
      
      private
      
      ##
      # Generate a slug via interpolation. 
      # 
      def auto_generate_slug
        return true if self.slug.present?
        self.slug = interpolate_slug
      end
      
      ##
      # Takes the models interpolation string and 
      # generates a slug. By default this is simply :title
      # 
      def interpolate_slug
        interpolation = self.delivery_options.sluggable.to_s.sub(/^:/, '')
        ::Transit::Interpolations.interpolate(":#{interpolation}", self)
      end

    end
    
  end
end