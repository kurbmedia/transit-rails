require 'spec_helper' 

describe "Draft Extension" do
  
  let!(:region) do
    Transit::Region.make
  end
  
  
  it 'adds a deploy method' do
    region.respond_to?(:deploy)
      .should be_true
  end
  
  
  it 'includes the Publishable extension' do
    Transit::Region.included_modules
      .should include(Transit::Extensions::Draftable)
  end
  
  
  it 'configures draftable attributes' do
    region.send(:draftable_attributes)
      .should eq [:content]
  end
  
  describe 'updating content' do
    
    
  end
end