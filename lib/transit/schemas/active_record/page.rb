require 'ancestry'
require 'active_record'

module Transit
  class Page < ActiveRecord::Base
    serialize :keywords, Array
    has_many :regions, :class_name => "Transit::Region", :dependent => :destroy
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
  end
end