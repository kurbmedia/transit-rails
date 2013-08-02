require 'active_record'
require 'ancestry'

Transit.orm = :active_record

module Transit
  module Adapter
    ##
    # Alias order_by to order for compatability
    # 
    def order_by(*args)
      order(*args)
    end
  end
end

# autoload

module Transit
  module ActiveRecordExtensions
    
    def gte(opts)
      return self unless opts
      values = []
      query  = opts.keys.collect do |key|
        values << opts[key]
        "#{key.to_s} >= ?"
      end
      where(query.join(" AND "), values)
    end
    
    def lte(opts)
      return self unless opts
      values = []
      query  = opts.keys.collect do |key|
        values << opts[key]
        "#{key.to_s} <= ?"
      end
      where(query.join(" AND "), values)
    end
  end
end

Transit::Adapter.use_serialization = true

ActiveRecord::Relation.send(:include, Transit::ActiveRecordExtensions)
ActiveRecord::Base.send(:extend, Transit::Adapter)
ActiveRecord::Base.send(:extend, Transit::Models)
ActiveRecord::Base.class_eval do
  
  def set(key, value = nil)
    if key.is_a?(Hash)
      update_columns(key)
    else
      update_column(key, value)
    end
  end
end

require "transit/schemas/active_record/page"
require "transit/schemas/active_record/post"
