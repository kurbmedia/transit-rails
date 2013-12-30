module Transit
  class MenusController < TransitController
    helper_method :resource, :collection, :pages
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
        set_flash_message(:alert, I18n.t('transit.flash.menus.create.alert'))
        respond_with(resource) and return
      end
      set_flash_message(:notice, I18n.t('transit.flash.menus.create.notice'))
      respond_with(resource, location: transit.menu_path(resource))
    end
    
    
    def edit
      respond_with(resource)
    end
    
    
    def update
      mkey = resource.update_attributes(permitted_params) ? :notice : :alert
      set_flash_message(mkey, I18n.t("transit.flash.menus.update.#{mkey.to_s}"))
      respond_with(resource, location: transit.menu_path(resource))
    end
    
    
    def destroy
      resource.destroy
      set_flash_message(:notice, I18n.t("transit.flash.menus.destroy.notice"))
      respond_with(resource, location: transit.menus_path)
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
      return params[:menu] unless Rails.version.to_i >= 4
      params.require(:menu).permit([ 
        :id, :name, :identifier, items_attributes: [ :id, :_destroy, :url, :title, :target, :parent_id, :position, :page_id, :temp_parent, :uid ]
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