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
        include Transit::Schemas::Post
        include Transit::Extensions::Slugged
        
        if Transit::Adapter.serialize_fields
          serialize :keywords, Array
          serialize :content_schema, Transit::Schematic
        end
        
        self.delivery_options.slugged ||= Transit.config.slug_posts_via
        
        if Transit.config.enable_validations
          validates_presence_of :title
        end
      end
      
      
    end
  end
end