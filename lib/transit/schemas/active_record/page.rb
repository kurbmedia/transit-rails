require 'ancestry'
require 'active_record'

module Transit
  module Schemas
    module Page
      extend ActiveSupport::Concern
      
      included do
        serialize :slug_map, Array
        serialize :content_schema, Transit::Schematic
        serialize :keywords, Array
        
        has_ancestry :orphan_strategy => :rootify, :cache_depth => true
        
        alias_attribute :post_date, :publish_date
      end
    end
  end
end