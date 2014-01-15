module Transit
  class PagesController < TransitController
    before_filter :perform_authentication_method
    helper_method :resource, :collection, :current_page, :parent_page 
    helper_method :collection_url, :resource_url, :edit_resource_url, :resource_instance_name
    layout "transit/modals", only: [:update]
    layout :transit_layout, only: [:show]
    respond_to :html, :js, :json

    
    def index
      @page_title = I18n.t('transit.titles.pages.index')
      if params[:parent_id].present?
        @page  = Transit::Page.find(params[:parent_id])
        @pages = resource.children
      end
      respond_with(collection)
    end
    
    
    ##
    # Publish all changes, making them live.
    # 
    def deploy
      unless resource.deploy!
        set_flash_message(:alert, I18n.t("transit.flash.pages.deploy.alert"))
        render json: {}, status: 401 and return
      end
      set_flash_message(:notice, I18n.t("transit.flash.pages.deploy.notice"))
      respond_with(resource)
    end
    
    
    def show
      if params[:mercury_frame].present?
        flash.discard
        append_view_path(Rails.root + '/app/views/transit/templates')
        render template: resource.template and return
      end
      @page_title = I18n.t('transit.titles.pages.edit', name: resource.name)
      respond_with(resource)
    end
    
    ##
    # Create a new page
    # 
    def new
      @page_title = I18n.t('transit.titles.pages.new')
      @page = Transit::Page.new
    end
    
    
    ##
    # Accept params for a new page and create it. 
    # 
    def create
      @page = Transit::Page.new(permitted_params)
      unless resource.save
        set_flash_message(:alert, I18n.t("transit.flash.pages.create.alert"))
        @page_title = I18n.t('transit.titles.pages.new')
        respond_with(resource) and return
      end
      set_flash_message(:notice, I18n.t("transit.flash.pages.create.notice"))
      loc = params[:edit_after].present? ? transit.page_path(resource) : transit.pages_path
      respond_with(resource, location: loc)
    end
    
    
    def edit
      if params[:mercury].present?
        render action: :edit, layout: 'transit/modals'
        return
      end
      @page_title = I18n.t('transit.titles.pages.edit', name: resource.name)
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
    # URL to access the 'index' view for the resource being edited.
    # 
    def collection_url
      transit.pages_path
    end
    
    
    ##
    # The url to access the 'edit' action for this resource. Allows other controllers to 
    # utilize the editor. When using this method, make sure the "mercury" param is provided 
    # when you wish to use the editor rather than the default 'edit' view.
    # 
    def edit_resource_url(parm = {})
      transit.edit_page_path(resource, parm)
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
    # Create a resource_url helper to be compatable with IR, and allow other 
    # controllers to utilize the editor by providing a save_url
    # 
    def resource_url
      resource.absolute_path
    end
    
    
    ##
    # Provides a param key so the editor knows how to submit data to update actions.
    # 
    def resource_instance_name
      :page
    end
    
    
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