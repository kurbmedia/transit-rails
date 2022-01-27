require 'rails_helper'

describe Transit::Region do
  
  let!(:page) do
    create(:page)
  end
  
  describe 'attributes' do
    
    let!(:region) do
      Transit::Region.new(
        id: "dom_id",
        content: "test"
      )
    end
    
    it 'accepts a hash and assigns variables' do
      region.id
        .should eq 'dom_id'
    end
    
    it 'assigns the hash to .attributes' do
      region.attributes
        .keys.should include('id')
    end
  end
end