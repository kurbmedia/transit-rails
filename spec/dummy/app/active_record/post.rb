class Post < ActiveRecord::Base  
  deliver_as :post, :publishable
end