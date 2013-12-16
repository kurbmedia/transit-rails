module Transit
  module Extensions
    ##
    # Enables publishing functionality state for models.
    # This includes the ability to modify the model's attributes/content
    # without effecting its "real" data.
    # 
    module Draftable
      extend ActiveSupport::Concern
      
      included do
        
        # Create a Draft class for this model.
        const_set 'Draft', Class.new(::Transit::Draft) unless const_defined?('Draft')
        options = { :class_name => "#{self.name}::Draft", :as => :draftable, :dependent => :destroy, :autosave => true }
        options.merge!(:autobuild => true ) if Transit.orm == :mongoid
        
        has_one *[:draft, options]
        
        delegate :draftable_attributes, :draft_class, :to => self
        
        draftable_attributes.map(&:to_s).each do |prop|
          
          ##
          # Override setter to update the draft instead of the model's attribute.
          # To make 'live' the deploy method should be used.
          # 
          define_method(:"#{prop}=") do |value|
            raise Transit::ReadOnlyRecord and return if preview?
            write_attribute('draft_state', 'draft') if respond_to?(:draft_state=)
            draft.write_property(prop, value)
          end
          
          ##
          # Create a draft_* getter for each draftable attribute.
          # This way we can get the current content 
          # 
          # @author brent
          define_method(:"draft_#{prop}") do
            draft.read_property(prop)
          end
          
          define_method(:"#{prop}") do
            read_attribute(prop) || draft.read_property(prop)
          end
        end
      end
      
      module ClassMethods
        
        ##
        # Reference to the class which drafts are based on
        # 
        def draft_class
          const_get('Draft')
        end
        
        ##
        # The fields/attributes that are draftable.
        # 
        def draftable_attributes
          [self.delivery_options.draftable].flatten.uniq.map(&:to_sym)
        end
      end
      
      ##
      # Places a model in a 'preview' state, that way 
      # draft content can be assigned but the model can't be saved, updated, 
      # or destroyed etc.
      # 
      module PreviewMode
        extend ActiveSupport::Concern

        included do
          draftable_attributes.each do |prop|
            attr_readonly(prop)
          end
        end
        
        
        ##
        # Block destruction when previewing
        # 
        def destroy
          raise Transit::ReadOnlyRecord
        end
        
        
        ##
        # Block destruction when previewing
        # 
        def delete
          raise Transit::ReadOnlyRecord
        end
        
        
        ##
        # We're now in preview mode.
        # 
        def preview?
          true
        end
        
        
        ##
        # When previewing, models should be in a readonly state.
        # 
        def readonly?
          true
        end
      end
      
      
      ##
      # Overwrite all draftable attributes for this model with the draft content.
      # 
      def deploy
        draftable_attributes.each do |prop|
          write_attribute(prop, draft.read_property(prop))
        end
        write_attribute('draft_state', 'published') if respond_to?(:draft_state=)
        self
      end
      
     
      ##
      # Override the current content with
      # 
      def deploy!
        deploy
        save
      end
      
      
      ##
      # Auto-build the draft
      # 
      def draft
        super || build_draft
      end
      
      
      ##
      # Are we in draft mode?
      # 
      def draft?
        return false unless self.respond_to?(:draft_state=)
        self.draft_state == 'draft'
      end
      
      
      ##
      # Place the model in a preview mode. 
      # Assigns draft content to the model, then 
      # makes it readonly.
      # 
      def preview!
        draftable_attributes.each do |prop|
          value = draft.read_property(prop)
          next if value.nil?
          self.send(:write_attribute, prop, value)
        end
        extend Transit::Extensions::Draftable::PreviewMode
        self
      end
      
      
      ##
      # Are we in preview mode?
      # 
      def preview?
        false
      end      
    end
  end
end