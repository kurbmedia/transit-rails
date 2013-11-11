module Transit
  module Delivery
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_page
    end
    
    
    ##
    # Default show action for controllers responsible 
    # for rendering pages.
    # 
    def show
      render template: current_template
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
      "pages/#{current_page.try(:template) || 'default'}"
    end
  end
end