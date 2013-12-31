require 'spec_helper'

describe Transit::Media do
  
  describe 'associations' do
    
    it 'belongs to a folder' do
      should belong_to(
        :folder)
    end
  end
  
  
  describe 'validations' do
    
    it 'requires a name' do
      should validate_presence_of(
        :name)
    end
  end
end