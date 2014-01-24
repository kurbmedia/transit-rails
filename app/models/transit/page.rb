require_dependency "transit/schemas/#{Transit.orm.to_s}/page"

module Transit
  class Page
    extend Transit::Templating
    
    # All pages should use publishing, slugs, and tracking
    transit :publishable, 
            sluggable: ':name',
            draftable: :region_data
    
    validates :title, :name, :slug, presence: true
    validate :slug_is_unique
    validates :identifier, uniqueness: true
    
    before_validation :sanitize_slug
    before_validation :generate_identifier
    
    has_many :attachments, class_name: "Transit::Media", as: :attachable

    scope :top_level, -> { roots }
    
    ##
    # The absolute path to this page
    # 
    def absolute_path
      File.join('/', self.slug.to_s)
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
    # When explicitly publishing pages, 
    # deploy all region changes.
    # 
    def publish!
      deploy
      super
    end
    
    
    ##
    # Build regions from the stored data hash. 
    # 
    def regions
      @regions ||= RegionBuilder.new(self.region_data || self.draft_region_data)
    end
    
    
    private

    ##
    # If an identifier hasn't been set, auto-generate 
    # one from the name of the page.
    # 
    def generate_identifier
      self.identifier ||= self.name.to_s.to_slug.underscore
    end
    
    
    ##
    # In the event slugs are entered by end-users, this ensures they are 
    # always truncated to non-absolute paths. 
    # 
    def sanitize_slug
      return true unless self.slug.present?
      self.slug = _sanitize_uri_fragment(self.slug)
    end
    
    
    ##
    # Check for unique slugs. Within the base install, this method 
    # is simply stubbed out. It exists to allow uniqueness checking 
    # from extensions/additional engines etc. 
    # 
    def slug_is_unique
      true
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