class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  deliver_as :post
end