module Transit
  class MenusController < TransitController
    helper_method :resource, :collection
    respond_to :json
    
    def index
      @menus = Transit::Menu.all
      respond_with(collection)
    end
    
    def show
      respond_with(resource)
    end
    
    def create
      @menu = Transit::Menu.new(permitted_params)
      resource.save
      respond_with(resource)
    end
    
    def update
      resource.update(permitted_params)
      respond_with(resource)
    end
     
    def destroy
      resource.destroy
      respond_with(resource)
    end
    
    
    protected
    
    ##
    # All available menus
    # 
    def collection
      @menus ||= Transit::Menu.order('name ASC').all
    end
    
    
    ##
    # Get a list of all of the existing pages
    # 
    def pages
      @pages ||= Transit::Page.roots.order('name ASC').all
    end
    
    
    ##
    # Optional strong params support
    # 
    def permitted_params
      params.require(:menu).permit([ 
        :id, :name, :identifier, 
        items_attributes: [ 
          :id, :_destroy, :url, :title, :target, :parent_id, 
          :position, :page_id, :temp_parent, :uid 
        ]
      ])
    end
    
    
    ##
    # The menu currently being manipulated.
    # 
    def resource
      @menu ||= params[:id].present? ? Transit::Menu.find(params[:id]) : Transit::Menu.new
    end
    
  end
end