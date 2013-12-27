module Transit
  class TransitController < ::ApplicationController
    before_filter :perform_authentication_method
    after_filter :set_xhr_flash
    
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
    
    
    ##
    # When using AJAX add a X-Flash-Messages header to the 
    # response so messages can be displayed.
    # 
    def set_xhr_flash
      return true unless request.xhr? && flash.any?
      result = []
      flash.each do |key, value|
        result.push << { key => value }
      end  
      response.headers['X-Flash-Messages'] = result.to_json unless result.empty?
      flash.discard
    end
    
  end
end