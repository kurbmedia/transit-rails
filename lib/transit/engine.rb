require 'transit'
require 'transit/delivery'

module Transit
  class Engine < ::Rails::Engine
    isolate_namespace Transit
    
    ActiveSupport.on_load(:action_controller) do
      helper Transit::Delivery::Regions
    end
  end
end