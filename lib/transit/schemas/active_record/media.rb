require 'active_record'

module Transit
  class Media < ActiveRecord::Base
    belongs_to :media_folder, class_name: 'Transit::MediaFolder'
  end
end