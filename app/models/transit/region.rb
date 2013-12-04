require_dependency "transit/schemas/#{Transit.orm.to_s}/region"

module Transit
  class Region
    transit :draftable => :content
  end
end