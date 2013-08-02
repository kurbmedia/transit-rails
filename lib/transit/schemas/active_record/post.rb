require 'ancestry'

module Transit
  module Schemas
    module Post
      extend ActiveSupport::Concern
      
      included do
        serialize :keywords, Array
        serialize :content_schema, Transit::Schematic
      end
    end
  end
end