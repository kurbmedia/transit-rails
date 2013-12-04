module Transit
  module Extensions
    ##
    # Enables "published" state for models.
    # By default this includes a boolean `published` field, 
    # as well as `publish_on`, allowing the ability to mark an
    # item as published, as well as set the date in which it is published.
    # 
    module Publishable
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
        def published_by_date
          where("published = ? AND publish_on >= ?", true, Date.today)
        end
        
        ##
        # Available items are defined as having a `available` value of true
        # and a available_on date before or on the current date.
        # 
        def published
          if self.delivery_options.publishable.present?
            meth = "published_by_#{self.delivery_options.publishable.to_s}"
            return self.send(meth.to_sym)
          end
          where(:published => true)
        end
        
      end
      
      ##
      # Make this model available immediately.
      # 
      def publish!
        self.published = true
        if self.respond_to?(:publish_on)
          self.publish_on ||= Date.today
        end
        self.save
      end

      private
      
      
      ##
      # If a resource has "available" set to true, but no 
      # date has been set, auto-set it to today.
      # 
      def check_for_availability_and_auto_set_date
        return true unless self.published? && self.published_changed?
        (self.publish_on ||= Date.today.to_time) if self.respond_to?(:publish_on)
        true
      end
      
    end
  end
end