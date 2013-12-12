module Transit
  class MenuItemsController < TransitController
    helper_method :collection
    respond_to :html, :js, :json
    
    def create
      respond_with(collection)
    end
    
    
    protected
    
    ##
    # Creates an array of new menu items for 
    # adding to a menu. 
    # 
    def collection
      @items ||= [item_data].flatten.compact.map do |data|
        data.symbolize_keys!
        Transit::MenuItem.new(data)
      end
    end
    
    
    private
    
    
    ##
    # Parse the serialized menu data from the params
    # 
    def item_data
      @idata ||= MultiJson.decode(params[:menu_items])
    end
  end
end