module Transit
  module Delivery
    autoload :Actions,  'transit/delivery/actions'
    
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_page, :current_template
      include Transit::Delivery::Actions  
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
  end
end