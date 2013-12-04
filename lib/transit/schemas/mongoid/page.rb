require 'mongoid-ancestry'
require 'mongoid/extensions/boolean'

module Transit
  class Page
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Ancestry
    
    field :name,              :type => String,  :localize => Transit.config.translate
    field :title,             :type => String,  :localize => Transit.config.translate
    field :description,       :type => String,  :localize => Transit.config.translate
    field :keywords,          :type => Array,   :default  => []
    field :slug,              :type => String
    field :identifier,        :type => String
    field :template,          :type => String,  :default => 'default'
    field :ancestry_depth,    :type => String
    field :position,          :type => Integer
    field :published,         :type => Boolean, :default => false
    field :publish_on,        :type => Date
    
    # Non-editable pages can only have their properties modified, and should not contain regions.
    # This allows using pages to only control/dictate metadata and other properties, for use with 
    # other models etc. 
    # 
    field :editable,          :type => Boolean, :default => true
    
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
    embeds_many :regions, :class_name => "Transit::Region", :cascade_callbacks => true
  end
end