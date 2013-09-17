require_dependency "transit/schemas/#{Transit.orm.to_s}/page"

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

  end
end