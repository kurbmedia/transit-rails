module Transit
  module Models
    module Base
      extend ActiveSupport::Concern
      
      included do
        transit_attribute :content, String, :default => "", :localize => self.has_translation_support
        transit_attribute :content_schema, Transit::Schematic, :default => {}
      end
    end
  end
end