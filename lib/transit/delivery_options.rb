require 'ostruct'

module Transit
  ##
  # Maintains configuration data for extensions and other options. 
  # When extensions are used, this configuration is accessed
  # to decide how to handle particular features and functionality.
  # 
  class DeliveryOptions < ::OpenStruct
    
    ##
    # Merge options and values from hash data.
    # 
    # @param [Hash] hash A hash of options and values to merge, overrides any existing values.
    # 
    def merge!(hash = {})
      hash.each_pair do |key, value|
        self.send(:"#{key.to_s}=", value)
      end
    end
    
    ##
    # Similar to hash.reverse_merge!, assigns options and values 
    # unless they already exist.
    # 
    # @param [Hash] hash A hash of options to merge into the openstruct, existing items are skipped.
    # 
    def reverse_merge!(hash = {})
      hash.each_pair do |key, value|
        next unless self.try(:"#{key.to_s}")
        self.new_ostruct_member(:"#{key.to_s}")
        self.send(:"#{key.to_s}=", value)
      end
    end
    
    private
    
    ##
    # If a method does not exist, add it to the openstruct, and assign the value.
    # Should the method already exist, optionally overwrite the previous value.
    # 
    # @param [String,Symbol] name The property name to create or update
    # @param [Mixed] value The value to assign to the property
    # @param [Boolean] overwrite When true, overrites any existing values for the passed property name
    # 
    def add_or_update_method(name, value, overwrite = true)
      unless self.respond_to?(:"#{name.to_s}")
        self.new_ostruct_member(:"#{name.to_s}")
        self.send(:"#{name.to_s}=", value)
      end
      self.send(:"#{name.to_s}=", value) unless overwrite == false
    end 
  end
end