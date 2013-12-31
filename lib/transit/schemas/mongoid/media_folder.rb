require 'mongoid-ancestry'

module Transit
  class MediaFolder
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Ancestry
    
    field :name,              :type => String
    field :ancestry_depth,    :type => String
    field :full_path,         :type => String
    
    # Media uploads belong to a folder
    has_many :files, class_name: "Transit::Media"
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
  end
end