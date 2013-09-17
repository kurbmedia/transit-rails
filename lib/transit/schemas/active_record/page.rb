require 'ancestry'
require 'active_record'

module Transit
  module Schemas
    module Page
      extend ActiveSupport::Concern
      
      included do
        serialize :keywords, Array
        has_ancestry :orphan_strategy => :rootify, :cache_depth => true
      end
    end
  end
end

Transit::Page.send(:include, Transit::Schemas::Page)