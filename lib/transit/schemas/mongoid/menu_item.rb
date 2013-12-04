require 'mongoid-ancestry'

module Transit
  class MenuItem
    include Mongoid::Document
    include Mongoid::Ancestry
    
    field :title,             :type => String
    field :url,               :type => String
    field :target,            :type => String
    field :ancestry_depth,    :type => String
    
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
    
    embedded_in :menu, :class_name => "Transit::Menu"
  end
end