module Transit
  class Menu < ApplicationRecord
    
    validates :name, :identifier, presence: true
    validates :name, :identifier, uniqueness: true

    before_validation :generate_identifier
    after_save :rebuild_item_heirarchy

    has_many :items, class_name: "Transit::MenuItem", dependent: :destroy
    
    accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank
    alias :menu_items_attributes= :items_attributes=
    
    ##
    # When creating new items that are nested, we can't always assign the "parent" menu item until it is saved. 
    # To allow our nested fields to support assigning children before saving, we use each item's "uid" 
    # as a temporary parent or identifier. Once Rails has finished its job on the attributes, we create a 
    # temporary hash of child => parent assignments to be used after save.
    # 
    def items_attributes=(data = {})
      self.menu_items_attributes = data
      fixes = {}
      data.each do |index, props|
        next unless props['temp_parent'].present?
        fixes.merge!(props['uid'] => props['temp_parent'])
      end
      @nodes_to_fix = fixes
      data
    end
    
    private
    
    ##
    # Unless an identifier has been set, 
    # auto-generate one from the name
    # 
    def generate_identifier
      self.identifier ||= self.name.to_s.to_slug.underscore
    end
    
    
    ##
    # If any pending parent => child relations are available, loop and assign them.
    # 
    def rebuild_item_heirarchy
      return true unless @nodes_to_fix.present?
      self.reload
      @nodes_to_fix.each do |cid, pid|
        item  = self.items.where(uid: cid).first
        next unless item
        found = self.items.where(uid: pid).first
        item.update(parent: found)
      end
      @nodes_to_fix = nil
      true
    end
  end
end