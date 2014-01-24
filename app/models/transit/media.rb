require_dependency "transit/schemas/#{Transit.orm.to_s}/media"

module Transit
  class Media

    validates :name, presence: true
  end
end