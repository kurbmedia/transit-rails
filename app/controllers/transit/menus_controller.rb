module Transit
  class MenusController < TransitController
    helper_method :resource, :collection, :current_page
    respond_to :html, :js, :json
    
    def index
      @menus = Transit::Menu.all
      respond_with(collection)
    end
    
    
    def show
      respond_with(resource)
    end
    
    ##
    # Create a new meu
    # 
    def new
      @menu = Transit::Menu.new
    end
    
    
    ##
    # Accept params for a new page and create it. 
    # 
    def create
      @menu = Transit::Menu.new(permitted_params)
      unless resource.save
        respond_with(resource) and return
      end
      respond_with(resource, location: transit.menu_path(resource))
    end
    
    
    def edit
      respond_with(resource)
    end
    
    
    def update
      resource.update_attributes(permitted_params)
      respond_with(resource, location: transit.menu_path(resource))
    end
    
    
    def destroy
      resource.destroy
      respond_with(resource, location: transit.menus_path)
    end
    
    
    protected
    
    ##
    # All available menus
    # 
    def collection
      @menus ||= Transit::Menu.all
    end
    
    
    ##
    # Optional strong params support
    # 
    def permitted_params
      return params[:menu] unless Rails.version.to_i >= 4
      params.require(:menu).permit!
      # params.permit(:page => [ 
      #   :id, :name, :title, :description, :keywords, :slug, :template, :parent_id, :published, :publish_on, :regions_attributes => {}
      # ])
    end
    
    
    ##
    # The menu currently being manipulated.
    # 
    def resource
      @menu ||= params[:id].present? ? Transit::Menu.find(params[:id]) : Transit::Menu.new
    end
    
  end
end