require 'ancestry'
require 'active_record'

module Transit
  class MediaFolder < ActiveRecord::Base
    # Media uploads belong to a folder
    has_many :files, class_name: "Transit::Media", foreign_key: :folder_id
    has_ancestry :orphan_strategy => :rootify, :cache_depth => true
  end
end