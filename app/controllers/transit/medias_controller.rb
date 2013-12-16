module Transit
  class MediasController < TransitController
    helper_method :resource, :collection
    respond_to :html, :js, :json
    
    def index
      @menus = Transit::Media.all
      respond_with(collection)
    end
    
    
    def show
      respond_with(resource)
    end
    
    ##
    # Create a new meu
    # 
    def new
      @menu = Transit::Media.new
    end
    
    
    ##
    # Accept params for a new page and create it. 
    # 
    def create
      @menu = Transit::Media.new(permitted_params)
      unless resource.save
        set_flash_message(:alert, I18n.t('transit.flash.medias.create.alert'))
        respond_with(resource) and return
      end
      set_flash_message(:notice, I18n.t('transit.flash.medias.create.notice'))
      respond_with(resource, location: transit.media_path(resource))
    end
    
    
    def edit
      respond_with(resource)
    end
    
    
    def update
      mkey = resource.update_attributes(permitted_params) ? :notice : :alert
      set_flash_message(mkey, I18n.t("transit.flash.medias.update.#{mkey.to_s}"))
      respond_with(resource, location: transit.media_path(resource))
    end
    
    
    def destroy
      resource.destroy
      set_flash_message(:notice, I18n.t("transit.flash.medias.destroy.notice"))
      respond_with(resource, location: transit.medias_path)
    end
    
    
    protected
    
    ##
    # All available uploads
    # 
    def collection
      @menus ||= Transit::Media.order('name ASC').all
    end
    
    
    ##
    # Optional strong params support
    # 
    def permitted_params
      return params[:media] unless Rails.version.to_i >= 4
      params.require(:media).permit([ :name, :folder_id ])
    end
    
    
    ##
    # The menu currently being manipulated.
    # 
    def resource
      @menu ||= params[:id].present? ? Transit::Media.find(params[:id]) : Transit::Media.new
    end
    
  end
end