module Transit
  class Region
    
    ##
    # Overwrite the current content for this region 
    # with the working copy.
    # 
    def publish
      self.content = self.draft_content
    end
    
    ##
    # Publish the new content permanently.
    # 
    def publish!
      self.update_attribute(:content, self.draft_content)
    end
  end
end

require_dependency "transit/schemas/#{Transit.orm.to_s}/region"