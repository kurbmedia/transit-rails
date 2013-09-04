require "transit/engine"

module Transit
  extend self
  include ActiveSupport::Configurable
  
  autoload :Deliverable,  'transit/deliverable'
  autoload :Models,       'transit/models'
  autoload :Context,      'transit/context'
  autoload :Schematic,    'transit/schematic'
  
  mattr_accessor :deliverables
  @@deliverables = {}
  
  mattr_accessor :orm
  @@orm = :mongoid
  
  ##
  # Register a deliverable class based 
  # on its type.
  # 
  # @param [Class] klass The deliverable class
  # @param [Symbol] type The type of deliverable
  # 
  # 
  def add_deliverable(klass, type)
    self.deliverables[type] ||= []
    self.deliverables[type] << klass.name
  end
  
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
require 'transit/delivery_options'

require 'transit/models'
require 'transit/adapter'
require 'transit/interpolations'
require 'transit/extensions'
require 'transit/core_ext/string'