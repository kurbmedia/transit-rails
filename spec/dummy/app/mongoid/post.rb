class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :published,         :type => Boolean, :default => false
  field :publish_date,      :type => Date
  
  alias_attribute :post_date, :publish_date
  
  deliver_as :post, :publishable
end