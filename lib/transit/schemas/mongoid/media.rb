module Transit
  class Media
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :name,          :type => String,  :localize => Transit.config.translate
    field :file_name,     :type => String
    field :content_type,  :type => String
    field :fingerprint,   :type => String
    field :file_size,     :type => Integer, :default  => 0
    field :media_type,    :type => String,  :default  => 'file'
  end
end