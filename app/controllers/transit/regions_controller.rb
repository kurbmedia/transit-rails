module Transit
  class RegionsController < TransitController
    respond_to :json
    
    ##
    # Update a region within a page by ID.
    #
    def update
      current_data = page.region_data || {}
      region_id    = params[:id].to_s
      
      page.update(
        region_data: current_data.merge(
          region_id => region_params.to_h
        ))
      
      region = page.regions.find(region_id)
      respond_with region and return
    end

    alias_method :create, :update

    ##
    # Render the region with the passed id if utilized within page scope.
    # Otherwise render a region definition.
    #
    def show
      region = if page_scoped?
        page.regions.find(params[:id])
      else Transit::Region.new
      end

      respond_with region and return
    end


    protected

    ##
    # The page
    #
    def page
      Transit::Page.find_by id: params[:page_id]
    end

    ##
    # Are we messing with regions within a page.
    #
    def page_scoped?
      params[:page_id].present?
    end


    ##
    # Strong params, we allow anything here because its just json.
    # This way arbitrary attributes can be assigned and custom regions can be created.
    #
    def region_params
      params.require(:region).permit!
    end
  end
end
