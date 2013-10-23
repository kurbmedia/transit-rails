module Transit
  module Extensions
    ##
    # Enables "availability" state for models.
    # By default this includes a boolean `available` field, 
    # as well as `available_on`, allowing the ability to mark an
    # item as available, as well as set the date in which it is available.
    # 
    module Available
      extend ActiveSupport::Concern
      
      included do
        # Alias post_date for convenience and as a sensible name for post type deliverables.
        before_save :check_for_availability_and_auto_set_date
      end
      
      ##
      # Class level methods and functionality
      # 
      module ClassMethods
        
        ##
        # Create an additional scope for finding items 
        # available by property AND date.
        # 
        def available_by_date
          where("available = ? AND available_on >= ?", true, Date.today)
        end
        
        ##
        # Available items are defined as having a `available` value of true
        # and a available_on date before or on the current date.
        # 
        def available
          if self.delivery_options.available.present?
            meth = "available_by_#{self.delivery_options.available.to_s}"
            return self.send(meth.to_sym)
          end
          where(:available => true)
        end
        
      end
      
      ##
      # Make this model available immediately.
      # 
      def available!
        self.available = true
        if self.respond_to?(:available_on)
          self.available_on ||= Date.today
        end
        self.save
      end

      private
      
      
      ##
      # If a resource has "available" set to true, but no 
      # date has been set, auto-set it to today.
      # 
      def check_for_availability_and_auto_set_date
        return true unless self.available? && self.available_changed?
        (self.available_on ||= Date.today.to_time) if self.respond_to?(:available_on)
        true
      end
      
    end
  end
end