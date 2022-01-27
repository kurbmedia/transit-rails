module Transit
  class Setting < ApplicationRecord

    serialize :options
    
    class_attribute :value_mappings, instance_writer: false
    self.value_mappings ||= {
        "boolean" => :to_bool,
        "string"  => :to_s,
        "integer" => :to_i,
        "decimal" => :to_f,
        "class"   => :constantize,
        "object"  => nil,
        "array"   => nil
       }
    
    
    class << self
      
      ##
      # Allows adding or overriding value_type mappings
      # @param [String,Symbol] type The value_type to be mapped
      # @param [String,Symbol] method The method which will be run on the value.
      # 
      def add_mapping!(type, method)
        value_mappings.merge!(type.to_s => method.to_sym)
      end
      
      
      ##
      # Outputs all available value types using the 
      # value_mappings hash.
      # 
      def value_types
        value_mappings.keys
      end
    end
    
    
    validates :key, :value_type, presence: true
    validates :key, uniqueness: true

    before_save :convert_value
    after_save :update_global_settings
    
    
    ##
    # Override getter for value to coerce the stored 
    # value into its proper format.
    # 
    def value
      @clean_val ||= proper_value
    end
    
    
    ##
    # Override setter to properly marshal object type values.
    # 
    def value=(val)
      val = Marshal.dump(val) if !val.is_a?(String) || value_type == 'object'
      @clean_val = nil
      write_attribute('value', val)
    end
    
    
    ##
    # Ensure options use string keys
    # 
    def options
      (read_attribute('options') || {}).stringify_keys!
    end
    
    
    private
    
    
    ##
    # If the value_type is an object or other type that needs conversion, 
    # perform that conversion before saving.
    # 
    def convert_value
      return true unless ['object'].include?(self.value_type)
      base = read_attribute('value')
      return true if base.nil? || base.is_a?(String)
      write_attribute('value', Marshal.dump(base))
      @clean_val = nil
      true
    end
    
    
    ##
    # Converts the value to the proper object type based on
    # the 'value_type' field
    # 
    def proper_value
      base    = read_attribute('value')
      return nil unless base
      converter = options['conversion_method'] || self.value_mappings[value_type]
      case value_type
      when 'object'
        return base.is_a?(String) ? Marshal.load(base) : base
      when 'array'
        base.is_a?(Array) ? base : base.to_s.split(options['separator'] || ',')
      else
        return base unless converter
        base.send(converter)
      end
    end
    
    
    ##
    # After a setting is saved, update the global setting hash.
    # 
    def update_global_settings
      Transit.settings.merge!(self.key.to_s => self.value)
    end
  end
end
