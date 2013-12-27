module Transit
  class PagesController < TransitController
    helper_method :resource, :collection, :current_page, :parent_page
    layout :transit_layout, only: [:show]
    respond_to :html, :js, :json
    
    
    def index
      if params[:parent_id].present?
        @page  = Transit::Page.find(params[:parent_id])
        @pages = resource.children
      end
      respond_with(collection)
    end
    
    
    def show
      if params[:mercury_frame].present?
        append_view_path(Rails.root + '/app/views/transit/templates')
        render template: resource.template and return
      end
      respond_with(resource)
    end
    
    ##
    # Create a new page
    # 
    def new
      @page = Transit::Page.new
    end
    
    
    ##
    # Accept params for a new page and create it. 
    # 
    def create
      @page = Transit::Page.new(permitted_params)
      unless resource.save
        set_flash_message(:alert, I18n.t("transit.flash.pages.create.alert"))
        respond_with(resource) and return
      end
      set_flash_message(:notice, I18n.t("transit.flash.pages.create.notice"))
      respond_with(resource, location: transit.page_path(resource))
    end
    
    
    def edit
      if params[:mercury].present?
        render action: :edit, layout: false
        return
      end
      respond_with(resource)
    end
    
    
    def update
      ftype = resource.update_attributes(permitted_params) ? :notice : :alert
      set_flash_message(ftype, I18n.t("transit.flash.pages.update.#{ftype.to_s}"))
      respond_with(resource, location: transit.page_path(resource))
    end
    
    
    def destroy
      ftype = resource.destroy ? :notice : :alert
      set_flash_message(ftype, I18n.t("transit.flash.pages.destroy.#{ftype.to_s}"))
      respond_with(resource, location: transit.pages_path)
    end
    
    
    protected
    
    ##
    # Top level pages.
    # 
    def collection
      @pages ||= Transit::Page.roots
    end
    
    
    ##
    # If a parent param is present, this is the 'parent' page 
    # we should load children for.
    # 
    def parent_page
      @parent ||= if params[:parent].present?
        Transit::Page.find(params[:parent])
      else nil
      end
    end
    
    
    ##
    # Optional strong params support
    # 
    def permitted_params
      return params[:page] unless Rails.version.to_i >= 4
      params.require(:page).permit!
      # params.permit(:page => [ 
      #   :id, :name, :title, :description, :keywords, :slug, :template, :parent_id, :published, :publish_on, :regions_attributes => {}
      # ])
    end
    
    
    ##
    # The page currently being manipulated.
    # 
    def resource
      @page ||= params[:id].present? ? Transit::Page.find(params[:id]) : Transit::Page.new
    end
    
    alias :current_page :resource
    
    
    ##
    # When in 'edit' mode, we need to render the mercury layout to 
    # configure the editor.
    # 
    def transit_layout
      return send(:_layout) if params[:mercury_frame].present? && resource.persisted? && resource.editable?
      params[:mercury_frame] = resource.absolute_path
      'transit'
    end
    
  end
end