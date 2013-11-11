require 'transit/delivery'

module Transit
  class PagesController < ApplicationController
    helper_method :resource, :collection
    
    protected
    
    def collection
      @pages = Page.roots
    end
    
    def resource
      @page ||= Page.find(params[:id])
    end
  end
end