require 'mongoid-ancestry'

module Transit
  class MediaFolder
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Ancestry
    
    field :name,              :type => String
    field :ancestry_depth,    :type => String
    
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
  end
end