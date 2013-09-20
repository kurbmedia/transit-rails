class Business < ActiveRecord::Base

  transit :sluggable => ":name"
end
