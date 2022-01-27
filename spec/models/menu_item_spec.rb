require 'rails_helper'

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
   
    it 'should belong to a menu' do
      should belong_to(
        :menu)
    end
  end
  
  
  describe '.page?' do
    
    let!(:page) do
      create(:page)
    end
    
    context 'when the menu item is tied to a page' do
      
      let!(:item) do
        Transit::MenuItem.new(page: page)
      end
      
      it 'returns true' do
        item.page?
          .should be_truthy
      end
    end
    
    
    context 'when the menu item is not tied to a page' do
      
      let!(:item) do
        Transit::MenuItem.new
      end
      
      it 'returns false' do
        item.page?
          .should be_falsey
      end
    end
  end
end