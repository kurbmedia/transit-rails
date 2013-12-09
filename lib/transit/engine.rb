module Transit
  class Engine < ::Rails::Engine
    isolate_namespace Transit
    
    config.to_prepare do
      ApplicationController.helper(Transit::RegionHelper)
    end
  end
end