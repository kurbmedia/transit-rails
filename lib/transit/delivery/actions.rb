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
        render template: current_template and return
      end
    end
  end
end