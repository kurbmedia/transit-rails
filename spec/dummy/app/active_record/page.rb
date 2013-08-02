class Page < ActiveRecord::Base
  deliver_as :page, :publishable, :orderable => :siblings
end
