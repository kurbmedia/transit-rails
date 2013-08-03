module Transit
  module Models
    ##
    # A page defines any full page-like model within a site. 
    # Pages have the same properties as standard html pages, including a title, 
    # a slug (url), keywords and descriptions.
    # 
    # 
    module Page
      extend ActiveSupport::Concern

      included do
        include Transit::Schemas::Page
        
        if Transit::Adapter.serialize_fields
          serialize :slug_map, Array
          serialize :content_schema, Transit::Schematic
          serialize :keywords, Array
        end
        
        before_save :sanitize_path_names
        before_save :generate_paths
        before_create :generate_identifier
        
        if Transit.config.enable_validations
          validates_presence_of :title, :name
          validates_presence_of :slug, :allow_blank => true
        end
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
          parts = p.split("/")
          parts = parts.to_yaml if Transit::Adapter.serialize_fields
          where(:slug_map => parts)
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
      # Does this page have children?
      # 
      def pages?
        self.children.published.exists?
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
end