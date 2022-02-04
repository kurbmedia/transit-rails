module Transit
  class PagesController < TransitController
    helper_method :resource, :collection
    respond_to :json

    def index
      if params[:parent_id].present?
        @page  = Transit::Page.find(params[:parent_id])
        @pages = resource.children
      end
      respond_with(collection)
    end
  
    def show
      respond_with(resource)
    end

    def create
      @page = Transit::Page.new(page_params)
      resource.save
      respond_with(resource)
    end
    
    def update
      resource.update(page_params)
      respond_with(resource)
    end
     
    def destroy
      resource.destroy
      respond_with(resource)
    end
    
    
    protected
    
    ##
    # Top level pages.
    # 
    def collection
      @pages ||= Transit::Page.roots
    end
    
    
    ##
    # Strong params support
    # 
    def page_params
      params.require(:page).permit!
    end
    
    
    ##
    # The page currently being manipulated.
    # 
    def resource
      @page ||= params[:id].present? ? Transit::Page.find(params[:id]) : Transit::Page.new
    end
    
  end
end