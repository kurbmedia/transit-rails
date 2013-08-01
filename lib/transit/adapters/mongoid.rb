require 'mongoid'
require 'mongoid-ancestry'
require 'transit/adapter'

module Transit
  module Adapters
    module Mongoid
      
      ##
      # Create a field for the model, optionally 
      # auto-adding translation support.
      # 
      # @param [Symbol] name The field name
      # @param [Object] type The class used as the type.
      # @param [Hash] options Options to be set on the field.
      # 
      def transit_attribute(scope, name, type, options = {})
        options.reverse_merge!(:localize => self.has_translation_support) if options.has_key?(:localize)
        scope.instance_eval do
          field name, { :type => type }.merge(options)
        end
      end
      
      ##
      # Loads the ancestry gem and applies any passed options.
      # 
      # @param [Hash] options Options to be passed to the has_ancestry method
      # 
      def transit_ancestry(options = {})
        include Mongoid::Ancestry
        has_ancestry(options)
      end

      Transit::Adapter.send(:include, self)
    end
  end
end

Mongoid::Document::ClassMethods.send(:include, Transit::Adapter)