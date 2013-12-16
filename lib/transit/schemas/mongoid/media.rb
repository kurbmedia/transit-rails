module Transit
  class Media
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :name,       :type => String,  :localize => Transit.config.translate
    field :media_type, :type => String,  :default  => 'file'
  end
end