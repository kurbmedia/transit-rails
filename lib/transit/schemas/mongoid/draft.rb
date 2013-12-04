require 'mongoid'

module Transit
  class Draft
    include Mongoid::Document
    
    field :property,  :type => String
    field :content,   :type => String
    field :serialize, :type => Boolean, :default => false
  end
end