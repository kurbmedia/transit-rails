require 'active_record'

module Transit
  class Media < ActiveRecord::Base
    belongs_to :media_folder, class_name: 'Transit::MediaFolder'
    self.table_name = 'transit_medias'
  end
end