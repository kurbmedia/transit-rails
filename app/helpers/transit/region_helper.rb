module Transit
  module RegionHelper
    
    ##
    # Render html tag for a region, including the content.
    # 
    def region(id, type, options = {}, &block)
      tag     = options[:tag] || :div
      content = region_content(id)
      content_tag(tag, id: id.to_s, data: { mercury: type.to_s }) do
        block_given? ? capture(content, &block) : content.to_s.html_safe
      end
    end
    
    private
    
    def region_content(name)
      current_page.regions.detect do |reg|
        reg.dom_id.to_s == name
      end.try(:content)
    end
    
  end
end