class Business < ActiveRecord::Base
  include Transit::Deliverable
  delivery_as :slugged => ":name"
end
