require 'ancestry'
require 'active_record'

module Transit
  class Page < ActiveRecord::Base
    serialize :keywords, Array
    serialize :region_data, ActiveSupport::HashWithIndifferentAccess
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
  end
end