require 'active_record'

module Transit
  module Adapters
    module ActiveRecord
      
      ##
      # This is a no-op on ActiveRecord. Generators and migrations are used instead.
      # The exception is when the type of field is an array or a hash. 
      # In those cases, serialize is called for compatability.
      # 
      def transit_attribute(name, type, options = {})
        case type
        when Hash || Array
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
    end
  end
end

ActiveRecord::Base.send(:extend, Transit::Adapters::ActiveRecord)