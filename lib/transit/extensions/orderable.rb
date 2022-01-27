module Transit
  module Extensions
    ##
    # Many objects such as contexts and menu items use an ordering system 
    # based on a position attribute. This module mixes in that functionalty.
    # 
    module Orderable
      extend ActiveSupport::Concern
      
      included do
        before_create :set_default_position
        default_scope lambda{ order(position: :asc) }
      end
      
      ##
      # Move an item to a particular position, moving 
      # items "after" this to a higher position
      # 
      def reposition!(index)
        target     = get_object_for_position_counter
        collection = nil
        counting   = index
        
        if index > target.count
          index      = target.count
          counting   = 0
          collection = target.where("position <= ?", index)
        elsif index <= 0
          index = 1
          counting = 1
        end
        
        collection = collection || target.where("position >= ?", index)
        collection.each do |item|
          next if item.id == self.id
          counting = counting + 1
          item.update_column(:position, counting)
        end
        self.update_column(:position, index)
      end
      
      private
      
      ##
      # On create, new items are added to the bottom of the 'stack'.
      # Ordered items are always output in ascending order by their position.
      #       
      def set_default_position
        self.position ||= (get_object_for_position_counter.count.to_i + 1)
        true
      end
      
      ##
      # Gets a target for calculating position values
      # 
      def get_object_for_position_counter
        target = self.delivery_options.orderable || :siblings
        return self.send(target) if target
        self._parent.send(self.metadata.name) if self.respond_to?(:_parent)
      end
      
    end
  end
end