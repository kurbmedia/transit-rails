require 'spec_helper'

describe Transit::Media do
  
  describe 'validations' do
    
    it 'requires a name' do
      should validate_presence_of(
        :name)
    end
  end
end