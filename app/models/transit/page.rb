module Transit
  class Page
    
    # All pages should use publishing, slugs, and tracking
    transit :publishable, 
            :sluggable => :name
    
    validates :title, :name, :slug, presence: true
    
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
    
    ##
    # Update the content for this page
    # by rendering the resulting template.
    # 
    def publish(force = false)
      force ? self.regions.each(&:publish!) : self.regions.each(&:publish)
    end
    
    ##
    # Update the content for this page
    # permanently, and save the result.
    # 
    def publish!
      publish(true)
      ## TODO: capture the rendered content via url. 
    end
    
    ##
    # Assigns regions based off of their dom ids.
    # 
    def region_data=(hash)
      hash.each do |dom, props|
        region = self.regions.where(:dom_id => dom).first || self.regions.build(:dom_id => dom)
        region.assign_attributes(props)
      end
    end

  end
end

require_dependency "transit/schemas/#{Transit.orm.to_s}/page"