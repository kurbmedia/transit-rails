module Transit
  module Schemas
    module Region
      extend ActiveSupport::Concern
      
      included do
        serialize :data
        belongs_to :page, class_name: "Transit::Page"
      end
      
    end
  end
end

Transit::Region.send(:include, Transit::Schemas::Region)