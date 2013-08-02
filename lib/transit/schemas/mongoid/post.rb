module Transit
  module Schemas
    module Post
      extend ActiveSupport::Concern
      
      included do
        field :title,             :type => String,  :localize => Transit.config.translate
        field :teaser,            :type => String,  :localize => Transit.config.translate
        field :description,       :type => String,  :localize => Transit.config.translate
        field :keywords,          :type => Array,   :default  => []
        field :slug,              :type => String
        field :content,           :type => String, :default => "", :localize => Transit.config.translate
        field :content_schema,    :type => Transit::Schematic, :default => {}        
      end
    end
  end
end