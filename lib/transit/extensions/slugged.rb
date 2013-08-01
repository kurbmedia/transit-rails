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
      # Generate a slug from the title on save
      # 
      def auto_generate_slug
        self.slug ||= interpolate_slug
      end
      
      
      ##
      # Takes the models interpolation string and 
      # generates a slug. By default this is simply :title
      # 
      def interpolate_slug
        interpolation = self.delivery_options.slugged
        interpolation = Transit.config.slug_posts_via unless interpolation.present?
        ::Transit::Interpolations.interpolate(interpolation, self)
      end
    end
    
  end
end