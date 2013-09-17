module Transit
  module Extensions
    ##
    # Enables "publish" state for deliverable models.
    # By default this includes a boolean `published` field, 
    # as well as a `post_date`, allowing the ability to mark an
    # item as published, as well as set the date in which it is 
    # available.
    # 
    module Publishable
      extend ActiveSupport::Concern
      
      included do
        # Alias post_date for convenience and as a sensible name for post type deliverables.
        alias_attribute :post_date, :publish_date
        before_save :check_for_published_and_auto_set_date
      end
      
      ##
      # Class level methods and functionality
      # 
      module ClassMethods
        
        ##
        # Create an additional scope for finding items 
        # published by property AND date.
        # 
        def published_by_date
          where("published = ? AND publish_date >= ?", true, Date.today)
        end
        
        ##
        # Published items are defined as having a `published` value of true
        # and a publish_date before or on the current date.
        # 
        def published
          if self.delivery_options.publishable.present?
            meth = "published_by_#{self.delivery_options.publishable.to_s}"
            return self.send(meth.to_sym)
          end
          where(:published => true)
        end
        
      end

      private
      
      
      ##
      # If a resource has "published" set to true, but no 
      # date has been set, auto-set it to today.
      # 
      def check_for_published_and_auto_set_date
        return true unless self.published? && self.published_changed?
        self.publish_date ||= Date.today.to_time
        true
      end
      
    end
  end
end