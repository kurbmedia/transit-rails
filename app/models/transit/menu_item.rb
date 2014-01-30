require_dependency "transit/schemas/#{Transit.orm.to_s}/menu_item"

module Transit
  class MenuItem
    transit :orderable
    
    validates :title, :url, presence: true
    alias :items :children
    attr_accessor :temp_parent
    before_create :set_uid
    before_save :cleanup_urls
    
    ##
    # Is this menu item tied to a page.
    # 
    def page?
      !!self.page_id
    end
    
    
    ##
    # Each menu item has a uid created from its initial object_id used for ordering/sorting when 
    # items aren't persisted. 
    # 
    def uid
      read_attribute('uid').present? ? read_attribute('uid') : "item_#{self.object_id}"
    end
    
    
    private
    
    ##
    # Make sure urls are always downcased
    # 
    def cleanup_urls
      self.url = self.url.to_s.downcase
    end
    
    
    ##
    # Assign a unique identifier for this menu item using its temp_id
    # 
    def set_uid
      write_attribute('uid', self.uid)
    end
  end
end