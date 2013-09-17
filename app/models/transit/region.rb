require_dependency "transit/schemas/#{Transit.orm.to_s}/region"

module Transit
  class Region
    before_save :ensure_draft_content
    
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
    
    private
    
    ##
    # When saving, if there is no draft content for the 
    # region, copy it from the content.
    # 
    def ensure_draft_content
      return true if self.draft_content.present?
      self.draft_content = self.content
    end
  end
end