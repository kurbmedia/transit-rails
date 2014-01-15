module Transit
  class Setting < ActiveRecord::Base
    serialize :options, Hash
  end
end