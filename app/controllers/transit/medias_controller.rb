module Transit
  class MediasController < TransitController
    helper_method :resource, :collection
    helper_method :collection_url, :resource_url, :edit_resource_url, :resource_instance_name
    
    respond_to :html, :js, :json
    
    def index
      @page_title = I18n.t('transit.titles.medias.index')
      @menus = Transit::Media.all
      respond_with(collection)
    end
    
    
    def show
      @page_title = I18n.t('transit.titles.medias.show', name: resource.name)
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
      @menus ||= Transit::Media.order('created_at ASC').all
    end
    
    
    ##
    # URL to access the 'index' view for the resource being edited.
    # 
    def collection_url
      transit.medias_path
    end
    
    
    ##
    # The url to access the 'edit' action for this resource. Adds inherited_resources compatability.
    # 
    def edit_resource_url(parm = {})
      transit.edit_media_path(resource, parm)
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
    
    
    ##
    # Create a resource_url helper to be compatable with IR, and allow other 
    # controllers to utilize the editor by providing a save_url
    # 
    def resource_url
      transit.media_path(resource)
    end
    
    
    ##
    # Provides a param key so the editor knows how to submit data to update actions.
    # 
    def resource_instance_name
      :media
    end
    
  end
end