module Transit
  class Setting
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :key,        type: String
    field :value,      type: String
    field :value_type, type: String
    field :options,    type: Hash, default: {}
    
  end
end