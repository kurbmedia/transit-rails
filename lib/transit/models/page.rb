require 'transit/models/base'

module Transit
  ##
  # A page defines any full page-like model within a site. 
  # Pages have the same properties as standard html pages, including a title, 
  # a slug (url), keywords and descriptions.
  # 
  # 
  module Page
    extend ActiveSupport::Concern

    included do
      include Transit::Models::Base
      
      ##
      # Register the deliverable.
      # 
      self.delivery_type = :post
      Transit.add_deliverable(self, :post)
      
      transit_attribute :name, String,          :localize => Transit.config.translate
      transit_attribute :title, String,         :localize => Transit.config.translate
      transit_attribute :description, String,   :localize => Transit.config.translate
      transit_attribute :keywords, Array,       :default => []
      transit_attribute :slug, String
      transit_attribute :identifier, String
      transit_attribute :ancestry_depth, String
      transit_attribute :slug_map, Array,       :default => []
      
      include Transit::Extensions::Ordering
      self.method_for_position_counter = :siblings
      
      # Setup ancestry for page nesting
      transit_ancestry :orphan_strategy => :rootify, :cache_depth => true
      
      alias_method :pages, :children
      alias_method :pages=, :children=
      alias_method :page=, :parent=
      alias_method :page, :parent
      
      before_save :sanitize_path_names
      before_save :generate_paths
      before_create :generate_identifier
      validates_presence_of :title, :name
      validates_presence_of :slug, :allow_blank => true

    end
    
    ##
    # Class level methods and functionality
    # 
    module ClassMethods
      
      ##
      # Returns all top_level pages (those without children)
      # 
      def top_level
        roots
      end
      
      ##
      # Accepts a url fragment and returns the corresponding page.
      # @param [String] path The url fragment
      # 
      def from_path(p)
        where(:slug_map => p.split("/"))
      end
      
      ##
      # Returns all published pages
      # 
      def published
        where(:published => true)
      end
      
    end
    
    ##
    # Convenience method for returning the full path to this page.
    # @return [String] The full path
    # 
    def full_path
      return self.slug if [self.slug_map].flatten.compact.empty?
      self.slug_map.dup.join("/")
    end
    
    ##
    # Get the absolute path/url to this page from 
    # the top level domain.
    # 
    def absolute_path
      File.join("/", full_path)
    end
    
    alias :abs_path :absolute_path
    
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
      self.send(:"#{self.class.name.split("::").pop.pluralize.underscore}").published.exists?
    end
    
    ##
    # Override the slug setter to ensure 
    # clean urls.
    # 
    def slug=(value)
      write_attribute(:slug, _sanitize_uri_fragment(value.to_s))
    end
    
    private

    ##
    # Generates an array of slugs based on this page's nesting in the tree. 
    # When a page belongs to another (and even another) the resulting path stack 
    # should represent the full url to that page.
    # 
    #  
    def generate_paths
      parts = [self.ancestors(:to_depth => self.depth).collect(&:slug), self.slug].flatten.compact
      self.slug_map = parts.map do |part|
        _sanitize_uri_fragment(part)
      end.reject(&:blank?)
      
      # once the path is built, set the slug unless previously set
      write_attribute(:slug, self.full_path) if self.slug.nil?
      true
    end
    
    ##
    # On creation, if the identifier is nil, generate it from the name.
    # 
    def generate_identifier
      self.identifier ||= self.name.to_s.to_slug.underscore
    end
    
    ##
    # In the event slugs are entered by end-users, this ensures they are 
    # always truncated to non-absolute paths. It also checks against 
    # duplication of parent slug/path values.
    # 
    def sanitize_path_names
      unless self.parent.nil?
        slug_parts   = self.slug.to_s.split("/").compact
        parent_parts = self.parent.slug_map.dup
        self.slug    = slug_parts.drop_while{ |part| part == parent_parts.shift }.join("/")
      end
      unless [self.slug_map].flatten.compact.empty?
        self.slug_map.map!{ |part| _sanitize_uri_fragment(part) }
      end
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