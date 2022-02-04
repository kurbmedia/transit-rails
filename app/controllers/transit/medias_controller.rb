module Transit
  class MediasController < TransitController
    helper_method :resource, :collection
    respond_to :json
    
    def index
      @menus = Transit::Media.all
      respond_with(collection)
    end
    
    def show
      respond_with(resource)
    end

    def create
      @menu = Transit::Media.new(media_params)
      resource.save
      respond_with(resource) and return
    end
    
    def update
      resource.update(media_params)
      respond_with(resource)
    end
      
    def destroy
      resource.destroy
      respond_with(resource)
    end
    
    
    protected
    
    ##
    # All available uploads
    # 
    def collection
      @menus ||= Transit::Media.order('created_at ASC').all
    end
    
   
    ##
    # Optional strong params support
    # 
    def media_params
      params.require(:media).permit([ :name, :folder_id ])
    end
    
    
    ##
    # The media item currently being manipulated.
    # 
    def resource
      @menu ||= params[:id].present? ? Transit::Media.find(params[:id]) : Transit::Media.new
    end
  
  end
end