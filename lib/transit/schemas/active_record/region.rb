require 'active_record'

module Transit
  class Region < ActiveRecord::Base
    
    serialize :data
    serialize :snippet_data
    
    belongs_to :page, :class_name => "Transit::Page"
  end
end