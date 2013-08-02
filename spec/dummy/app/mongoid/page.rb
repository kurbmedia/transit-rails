class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :published,         :type => Boolean, :default => false
  field :publish_date,      :type => Date
  
  alias_attribute :post_date, :publish_date
  
  deliver_as :page, :publishable, :orderable => :siblings
end
