require 'ancestry'

module Transit
  class Page < ApplicationRecord

    include Transit::Model
    
    # All pages should use publishing, slugs, and tracking
    transit :publishable, 
            sluggable: ':name'
    
    validates :title, :name, :slug, presence: true
    validate :slug_is_unique
    validates :identifier, uniqueness: true
    
    before_validation :sanitize_slug
    before_validation :generate_identifier

    serialize :keywords
    has_ancestry orphan_strategy: :rootify, cache_depth: true
  
    has_many :attachments, class_name: "Transit::Media", as: :attachable

    scope :top_level, -> { roots }
    
    ##
    # The absolute path to this page
    # 
    def absolute_path
      File.join('/', Transit.config.inherit_parent_slugs ? absolute_path_with_ancestry : self.slug.to_s)
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
      update(region_data: region_draft)
      super
    end
    
    
    ##
    # Build regions from the stored data hash. 
    # 
    def regions
      RegionBuilder.new(self.region_data || self.region_draft_data)
    end
    
    
    private
    
    ##
    # When inherit_parent_slugs is enabled, the absolute_path for 
    # this page should include slugs from its parents.
    # 
    def absolute_path_with_ancestry
      [self.ancestors(:to_depth => self.depth).pluck(:slug), self.slug].flatten.compact.map do |part|
        sanitize_uri_fragment(part)
      end.reject(&:blank?)
    end

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
    # If inherit_parent_slugs is enabled, it also ensures that the parent slug 
    # isnt stored as part of the slug.
    # 
    # Also generates the full path. 
    # 
    def sanitize_slug
      return true unless self.slug.present?
      if Transit.config.inherit_parent_slugs && self.parent.present?
        slug_parts   = self.slug.to_s.split("/").compact
        parent_parts = self.ancestors(:to_depth => self.depth).pluck(:slug).reverse
        self.slug    = slug_parts.drop_while{ |part| part == parent_parts.shift }.join("/")
      end
      self.slug      = sanitize_uri_fragment(self.slug)
      self.full_path = self.absolute_path.sub(/^\//, '')
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
    def sanitize_uri_fragment(frag)
      return nil if frag.nil?
      frag   = frag.gsub(/^(http|ftp|sftp|file)?:?(\/{1,2})?/i, "")
      parts  = frag.split("/")
      parts.shift if (parts.size > 1 && parts.first =~ /.*(\.)[a-z]{2,4}/i)
      parts.join("/")
    end

  end
end