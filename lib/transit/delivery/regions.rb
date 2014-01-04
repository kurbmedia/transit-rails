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
        tag     = options.delete(:tag) || :div
        content = region_content(id)
        content ||= capture(&block) if block_given?
        content = content.to_s.strip.html_safe
        case type
        when :image
          return image_tag(content, data: { mercury: 'image' })
        else
          content_tag(tag, { id: id.to_s, data: { mercury: type.to_s }}.merge(options)) do
            content
          end
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