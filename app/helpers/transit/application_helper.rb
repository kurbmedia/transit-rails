module Transit
  module ApplicationHelper
    
    ##
    # Path to the mounted engine
    # 
    def transit_root_path
      ::Rails.application.routes.named_routes[:transit].path
    end
  end
end
