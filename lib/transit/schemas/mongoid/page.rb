require 'mongoid-ancestry'

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
    field :publish_date,      :type => Date
    
    # Final rendered html. 
    field :rendered_content, :type => String, :default => "", :localize => Transit.config.translate
    
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
    embeds_many :regions, :class_name => "Transit::Region"
  end
end