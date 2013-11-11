require 'spec_helper'

describe Transit::Menu do

  describe "validations" do
    
    it 'validates that a name exists' do
      should validate_presence_of(
        :name)
    end
    
    it 'validates that the name is unique' do
      should validate_uniqueness_of(
        :name)
    end
    
    it 'validates the presence of an identifier' do
      should validate_presence_of(
        :identifier)
    end
  end
  
  
  describe 'associations' do
    
    when_mongoid do
      it 'should embed_many menu items' do
        should embed_many(
          :items)
      end
    end
    
    when_active_record do
      it 'should have_many menu items' do
        should have_many(
          :items)
      end
    end
  end
  
end