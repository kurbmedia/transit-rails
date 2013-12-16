require 'ancestry'
require 'active_record'

module Transit
  class MediaFolder < ActiveRecord::Base
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
  end
end