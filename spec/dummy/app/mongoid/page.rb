class Page
  include Mongoid::Document
  include Mongoid::Timestamps

  deliver_as :page, :published
end
