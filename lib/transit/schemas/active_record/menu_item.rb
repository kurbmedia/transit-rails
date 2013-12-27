require 'ancestry'
require 'active_record'

module Transit
  class MenuItem < ActiveRecord::Base
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
    
    belongs_to :menu, :class_name => "Transit::Menu"
    belongs_to :page, :class_name => "Transit::Page"
  end
end