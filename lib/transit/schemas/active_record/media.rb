require 'active_record'

module Transit
  class Media < ActiveRecord::Base
    self.table_name = 'transit_medias'
    
    def self.files
      where('transit_medias.media_type NOT IN (?)', ['image', 'audio', 'video'])
    end
  end
end