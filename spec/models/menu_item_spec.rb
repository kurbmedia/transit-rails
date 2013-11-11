require 'spec_helper'

describe Transit::MenuItem do
  
  
  describe "validations" do
    
    it 'validates that a title exists' do
      should validate_presence_of(
        :title)
    end
    
    it 'validates that a url exists' do
      should validate_presence_of(
        :url)
    end
  end
  
  
  describe 'associations' do
    
    when_mongoid do
      it 'should be embedded_in a menu' do
        should be_embedded_in(
          :menu)
      end
    end
    
    when_active_record do
      it 'should belong to a menu' do
        should belong_to(
          :menu)
      end
    end
  end
end