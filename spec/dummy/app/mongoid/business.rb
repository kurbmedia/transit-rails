class Business
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name,    :type => String
  field :slug,    :type => String
  field :summary, :type => String

  include Transit::Deliverable
  delivery_as :slugged => ":name"
end
