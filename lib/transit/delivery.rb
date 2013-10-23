module Transit
  module Delivery
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_page
    end
    
    protected
    
    def current_page
      @current_page ||= Transit::Page.where(slug: params[:slug]).first
    end
  end
end