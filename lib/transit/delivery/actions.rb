module Transit
  module Delivery
    ##
    # Controller actions
    # 
    module Actions
      
      ##
      # Default show action for controllers responsible 
      # for rendering pages.
      # 
      def show
        render template: "transit/templates/%s" % [current_template]
      end
    end
  end
end