require_dependency "transit/schemas/#{Transit.orm.to_s}/page"

module Transit
  class Page
    transit :publishable, :sluggable => :name
    
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