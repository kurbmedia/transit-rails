require 'active_record'

module Transit
  class Region < ActiveRecord::Base
    serialize :data
    belongs_to :page, class_name: "Transit::Page"
  end
end