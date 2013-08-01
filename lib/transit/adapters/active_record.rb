require 'active_record'
require 'ancestry'

module Transit
  module Adapter
    ##
    # This is a no-op on ActiveRecord. Generators and migrations are used instead.
    # The exception is when the type of field is an array or a hash. 
    # In those cases, serialize is called for compatability.
    # 
    def transit_attribute(name, type, options = {})
      if [Hash, Array].include?(type)
        serialize name, type
      end
    end
    
    ##
    # Loads the ancestry gem and applies any passed options.
    # 
    # @param [Hash] options Options to be passed to the has_ancestry method
    # 
    def transit_ancestry(options = {})
      has_ancestry(options)
    end
    
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