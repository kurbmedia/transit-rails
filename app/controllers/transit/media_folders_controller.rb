module Transit
  class MediaFoldersController < TransitController
    helper_method :resource, :collection
    respond_to :html, :js, :json
    
    def index
      @menus = Transit::MediaFolder.all
      respond_with(collection)
    end
    
    
    def show
      respond_with(resource)
    end
    
    ##
    # Create a new meu
    # 
    def new
      @menu = Transit::MediaFolder.new
    end
    
    
    ##
    # Accept params for a new page and create it. 
    # 
    def create
      @menu = Transit::MediaFolder.new(permitted_params)
      unless resource.save
        set_flash_message(:alert, I18n.t('transit.flash.media_folders.create.alert'))
        respond_with(resource) and return
      end
      set_flash_message(:notice, I18n.t('transit.flash.media_folders.create.notice'))
      respond_with(resource, location: transit.medias_path)
    end
    
    
    def edit
      respond_with(resource)
    end
    
    
    def update
      mkey = resource.update_attributes(permitted_params) ? :notice : :alert
      set_flash_message(mkey, I18n.t("transit.flash.media_folders.update.#{mkey.to_s}"))
      respond_with(resource, location: transit.medias_path)
    end
    
    
    def destroy
      resource.destroy
      set_flash_message(:notice, I18n.t("transit.flash.media_folders.destroy.notice"))
      respond_with(resource, location: transit.medias_path)
    end
    
    
    protected
    
    ##
    # All available uploads
    # 
    def collection
      @menus ||= Transit::MediaFolder.order('name ASC').all
    end
    
    
    ##
    # Optional strong params support
    # 
    def permitted_params
      return params[:media_folder] unless Rails.version.to_i >= 4
      params.require(:media_folder).permit([ :name, :parent_id ])
    end
    
    
    ##
    # The menu currently being manipulated.
    # 
    def resource
      @menu ||= params[:id].present? ? Transit::MediaFolder.find(params[:id]) : Transit::MediaFolder.new
    end
    
  end
end