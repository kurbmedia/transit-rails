require_dependency "transit/schemas/#{Transit.orm.to_s}/menu_item"

module Transit
  class MenuItem
    validates :title, :url, presence: true
    alias :items :children
  end
end