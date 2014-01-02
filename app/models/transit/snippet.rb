module Transit
  ##
  # Used to represent a snippet within a mercury region. 
  # This allows us to do more complex things with them such as generating dynamic content etc.
  # 
  class Snippet
    extend ActiveModel::Naming
    attr_accessor :id, :name, :options
    
  end
end