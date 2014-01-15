module Transit
  class SettingsController < TransitController
    helper_method :collection
    respond_to :html, :js, :json
    
  end
end
