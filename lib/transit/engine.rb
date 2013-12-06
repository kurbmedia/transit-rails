module Transit
  class Engine < ::Rails::Engine
    isolate_namespace Transit
    
    ActiveSupport.on_load(:action_controller) do
      include Transit::Templating
    end
  end
end