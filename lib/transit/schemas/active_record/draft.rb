require 'active_record'

module Transit
  class Draft < ActiveRecord::Base
    serialize :content, ActiveSupport::HashWithIndifferentAccess
  end
end