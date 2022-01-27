require 'rails_helper'

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
    it 'should embed_many menu items' do
      should have_many(
        :items)
    end
  end
  
  
  describe 'assigning menu item parents by temp_parent' do
   
    let!(:menu) do
      Transit::Menu.create!(name: 'Main Menu')
    end
    
    let(:item1) do
      Transit::MenuItem.new(
        title: "Test1", 
        url: "/test"
      )
    end
    
    let(:item2) do
      Transit::MenuItem.new(
        title: "Test2", 
        url: "/test2"
      )
    end
    
    let(:fitem) do
      menu.items.where(title: 'Test1')
        .first
    end
    
    let(:litem) do
      menu.items.where(title: 'Test2')
        .first
    end

    it 'properly saves items and associates parents' do
    
      props1 = item1.attributes
      props2 = item2.attributes
      [props1, props2].each{ |h| h.delete('_id') }
      
      result = menu.update(
        items_attributes:{
          '0' => props1.merge('uid' => item1.uid),
          '1' => props2.merge('temp_parent' => item1.uid, 'uid' => item2.uid)
        }
      )
      
      menu.reload
      menu.items.count.should eq 2
      litem.reload.parent_id.should eq fitem.id
    end
  end
end