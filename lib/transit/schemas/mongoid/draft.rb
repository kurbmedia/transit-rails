require 'mongoid'

module Transit
  class Draft
    include Mongoid::Document
    field :content, :type => Hash
  end
end