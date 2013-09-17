require_dependency "transit/schemas/#{Transit.orm.to_s}/page"

module Transit
  class Page
    
    # All pages should use publishing, slugs, and tracking
    transit :publishable, 
            :sluggable => ':name'
    
    validates :title, :name, :slug, presence: true
    before_save :sanitize_slug
    scope :top_level, -> { roots }
    
    ##
    # The absolute path to this page
    # 
    def absolute_path
      File.join('/', self.slug)
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
    
    ##
    # Does this page have children?
    # 
    def pages?
      self.children.exists?
    end
    
    ##
    # Update the content for this page
    # by rendering the resulting template.
    # 
    def publish(force = false)
      force ? self.regions.each(&:publish!) : self.regions.each(&:publish)
      self.published = true
      if self.respond_to?(:publish_date)
        self.publish_date ||= Date.today
      end
      self
    end
    
    ##
    # Update the content for this page
    # permanently, and save the result.
    # 
    def publish!
      publish(true)
      save
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
    
    private
    
    ##
    # In the event slugs are entered by end-users, this ensures they are 
    # always truncated to non-absolute paths. 
    # 
    def sanitize_slug
      return true unless self.slug.present?
      self.slug = _sanitize_uri_fragment(self.slug)
    end

    ##
    # Removes protocols, and invalid characters from a url fragment
    # @param [String] frag The fragment to sanitize
    # 
    def _sanitize_uri_fragment(frag)
      return nil if frag.nil?
      frag   = frag.gsub(/^(http|ftp|sftp|file)?:?(\/{1,2})?/i, "")
      parts  = frag.split("/")
      parts.shift if (parts.size > 1 && parts.first =~ /.*(\.)[a-z]{2,4}/i)
      parts.join("/")
    end

  end
end