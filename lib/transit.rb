require "transit/engine"

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
  # Configure options using a block
  # 
  def setup
    yield config
  end
end


require 'transit/error'
require 'transit/configuration'
require 'transit/adapter'
require 'transit/interpolations'
require 'transit/model'
require 'transit/extensions'
require 'transit/core_ext/string'