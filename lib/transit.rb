require "transit/engine"

module Transit
  extend self
  include ActiveSupport::Configurable
  
  autoload :Page, 'transit/models/page'
  autoload :Post, 'transit/models/post'
  
  mattr_accessor :deliverables
  @@deliverables = {}
  
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
  # Configure options using a block
  # 
  def setup
    yield config
  end
end
