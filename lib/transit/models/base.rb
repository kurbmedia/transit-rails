module Transit
  module Models
    module Base
      extend ActiveSupport::Concern
      
      included do
        
        transit_attribute :content, String,      :default => ""
        transit_attribute :content_schema, Hash, :default => {}
        
        class_attribute :delivery_type
      end
    end
  end
end