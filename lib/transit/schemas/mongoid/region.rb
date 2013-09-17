module Transit
  module Schemas
    module Region
      extend ActiveSupport::Concern
      
      included do
        
        field :dom_id,  type: String
        field :content, type: String
        field :type,    type: String
        field :data,    type: Hash, default: {}
        
        embedded_in :page, class_name: "Transit::Page"
      end
      
    end
  end
end

Transit::Region.send(:include, Transit::Schemas::Region)