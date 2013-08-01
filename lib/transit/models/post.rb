module Transit
    module Models
    ##
    # Defines the base functionality for a Post type deliverable. A 'post' in its basic form 
    # can be described as any individual member of a 'feed' of many of the same or similar item.
    # 
    # Posts contain a `published` state which can be used to determine their availability for 
    # display on front-facing pages. They also include a post_date which can be used to 
    # pre-generate content to be displayed at a later point in time.
    # 
    module Post
      extend ActiveSupport::Concern

      included do
      
        transit_attribute :title, String,  :localize => self.has_translation_support
        transit_attribute :teaser, String, :localize => self.has_translation_support
        transit_attribute :slug, String
        
        include Transit::Extensions::Slugged
        include Transit::Extensions::Published
        
        self.delivery_options.slugged ||= Transit.config.slug_posts_via
        
        validates_presence_of :title
      end
      
      
    end
  end
end