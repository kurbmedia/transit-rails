module Transit
  module Delivery    
    autoload :Regions, 'transit/delivery/regions'
    
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_page, :current_template
      before_filter :setup_templates_path, only: [:show]
    end

    
    ##
    # Default show action for controllers responsible 
    # for rendering pages.
    # 
    def show
      render template: current_template and return
    end
    
    
    protected
    
    ##
    # The page currently being accessed.
    # 
    def current_page
      @current_page ||= Transit::Page.where(slug: params[:slug]).first
    end
    
    
    ##
    # The template for the current page, based off of the 
    # page's "template" attribute.
    # 
    def current_template
      current_page.try(:template) || 'transit/templates/default'
    end
    
    
    ##
    # Tell the controller where to find template files
    # 
    def setup_templates_path
      prepend_view_path( transit_templates_dir )
      prepend_view_path( File.join( Rails.root, 'app', 'templates' ) )
    end
    
    
    private
    
    ##
    # The templates dir within the gem.
    # 
    def transit_templates_dir
      @ttdir ||= File.join( Gem::Specification.find_by_name("transit").gem_dir, 'app', 'templates' ) 
    end
  end
end