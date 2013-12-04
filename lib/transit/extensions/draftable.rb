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
        after_create :ensure_draft_contents
        has_many :drafts, class_name: "Transit::Draft", as: :draftable, dependent: :destroy
      end
      
      
      ##
      # Overwrite all draftable attributes for this model with the draft content.
      # 
      def deploy
        draftable_attributes.each do |prop|
          write_attribute(prop, drafts.for_attribute(prop).try(:content))
        end
        self
      end
      
     
      ##
      # Override the current content with
      # 
      def deploy!
        deploy
        save
      end
      
      private

      
      ##
      # When saving, if there is no draft content for the 
      # publishable attr, copy it from the source.
      # 
      def ensure_draft_contents
        draftable_attributes.each do |prop|
          current = self.drafts.where(property: prop).first || self.drafts.build(property: prop)
          current.content = self.attributes[prop.to_s]
          current.save
        end
      end
      
      
      ##
      # The field/attribute that is publishable.
      # 
      def draftable_attributes
        [self.delivery_options.draftable].flatten.uniq.map(&:to_sym)
      end
    end
  end
end