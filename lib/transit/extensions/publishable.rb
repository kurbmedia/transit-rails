module Transit
  module Extensions
    ##
    # Enables publishing functionality state for models.
    # This includes the ability to modify the model's attributes/content
    # without effecting its "real" data.
    # 
    module Publishable
      extend ActiveSupport::Concern
      
    end
  end
end