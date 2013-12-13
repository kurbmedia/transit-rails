module Transit
  module Delivery
    ##
    # Controller actions
    # 
    module Actions
      extend ActiveSupport::Concern
      
      included do
        before_filter :setup_templates_dir, only: [:show]
      end
      def self.included(base)
        base.class_eval <<-CODE
          Rails.logger.info("ASDLASKJDLASJDASLKDJSALKJDLASKJ")
          def show
            Rails.logger.info("ASDLASKJDLASJDASLKDJSALKJDLASKJ")
            render template: current_template and return
          end
        CODE
      end
      
    end
  end
end