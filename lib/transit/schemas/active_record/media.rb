require 'active_record'

module Transit
  class Media < ActiveRecord::Base
    self.table_name = 'transit_medias'
  end
end