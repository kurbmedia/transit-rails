class Business
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name,    :type => String
  field :slug,    :type => String
  field :summary, :type => String

  transit :sluggable => ":name"
end
