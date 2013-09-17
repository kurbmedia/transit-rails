require 'mongoid-ancestry'

module Transit
  module Schemas
    module Page
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Ancestry
    
        field :name,              :type => String, :localize => self.has_translation_support
        field :title,             :type => String, :localize => self.has_translation_support
        field :description,       :type => String, :localize => self.has_translation_support
        field :keywords,          :type => Array,  :default  => []
        field :slug,              :type => String
        field :identifier,        :type => String
        field :ancestry_depth,    :type => String
        field :position,          :type => Integer

        # Final rendered html. 
        field :rendered_content, :type => String, :default => "", :localize => self.has_translation_support
        
        has_ancestry :orphan_strategy => :rootify, :cache_depth => true
      end
    end
  end
end

Transit::Page.send(:include, Transit::Schemas::Page)