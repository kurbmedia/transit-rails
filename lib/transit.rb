module Transit
  extend self
  include ActiveSupport::Configurable
  
  autoload :DeliveryOptions,  'transit/delivery_options'
  autoload :Delivery,         'transit/delivery'
  autoload :RegionBuilder,    'transit/region_builder'
  autoload :Templating,       'transit/templating'

  
  mattr_accessor :orm
  @@orm = :mongoid
  
  ##
  # Paperclip style interpolations
  # 
  # @see transit/interpolations
  # @param [String] key The key to interpolate
  # @param [Proc] block A proc/lambda to be called when performing interpolation
  # 
  def interpolates(key, &block)
    Transit::Interpolations[key] = block
  end
  
  
  ##
  # Access a setting by key
  # 
  def setting(key)
    settings[key.to_s] ||= Transit::Setting.where(key: key.to_s).first.try(:value)
  end
  
  
  ##
  # Collects all settings into a hash
  # 
  def settings
    @setting_data ||= Transit::Setting.all.inject({}) do |hash, st|
      hash.merge!(st.key.to_s => st.value)
    end
  end
  
  
  ##
  # Configure options using a block
  # 
  def setup
    yield config
  end
end


require 'transit/error'
require 'transit/configuration'
require "transit/engine"
require 'transit/adapter'
require 'transit/interpolations'
require 'transit/model'
require 'transit/extensions'
require 'transit/core_ext/string'