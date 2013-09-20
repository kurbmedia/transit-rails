require 'active_record'

module Transit
  class Menu < ActiveRecord::Base
    has_many :items, :class_name => "Transit::MenuItem"
  end
end