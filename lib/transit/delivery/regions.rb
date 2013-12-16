module Transit
  module Delivery
    ##
    # Adds helper methods for rendering region data within a template.
    # 
    module Regions
      
      ##
      # Render html tag for a region, including the content.
      # 
      def region(id, type, options = {}, &block)
        tag     = options[:tag] || :div
        content = region_content(id)
        content ||= capture(&block) if block_given?
        content_tag(tag, id: id.to_s, data: { mercury: type.to_s }) do
          content.to_s.strip.html_safe
        end
      end
    
    
      private
      
      
      ##
      # Capture the content from a particular region.
      # 
      def region_content(domid)
        current_page.regions.find(domid).try(:content)
      end
    
    end
  end
end