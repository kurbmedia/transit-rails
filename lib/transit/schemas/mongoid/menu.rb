module Transit
  class Menu
    include Mongoid::Document
    
    field :name,       type: String
    field :identifier, type: String
    
    embeds_many :items, :class_name => "Transit::MenuItem"
  end
end