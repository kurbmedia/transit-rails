require_dependency "transit/schemas/#{Transit.orm.to_s}/draft"

module Transit
  class Draft
    belongs_to :draftable, polymorphic: true
  end
end