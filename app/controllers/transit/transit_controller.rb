module Transit
  class TransitController < ::ApplicationController
    before_action :perform_authentication_method
    helper ::Rails.application.routes.url_helpers

    protected    
    
    ##
    # If an authentication method has been set in the config,
    # run it here.
    # 
    def perform_authentication_method
      runs = Transit.config.authentication_method
      return true unless runs.present? && self.respond_to?(runs)
      send(runs)
    end
   
    
    ##
    # Set a flash message for the response
    # 
    def set_flash_message(type, message)
      if request.xhr?
        flash.now[type] = message
      else
        flash[type] = message
      end
    end
  
  end
end