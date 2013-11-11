require_dependency "transit/schemas/#{Transit.orm.to_s}/menu"

module Transit
  class Menu
    validates :name, :identifier, presence: true
    validates :name, :identifier, uniqueness: true
    before_validation :generate_identifier
    
    
    private
    
    ##
    # Unless an identifier has been set, 
    # auto-generate one from the name
    # 
    def generate_identifier
      self.identifier ||= self.name.to_s.to_slug.underscore
    end
  end
end