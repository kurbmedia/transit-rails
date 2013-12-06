require 'spec_helper' 

describe "Draft Extension" do
  
  let!(:region) do
    Transit::Region.make(
      content: "live content"
    )
  end
  
  let!(:page) do
    Transit::Page.make!(
      regions: [region]
    )
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
  
  it 'creates a Draft class for the model' do
    expect{ Transit::Region.const_get('Draft') }
      .to_not raise_error
  end
  
  describe 'model content' do
    
    context 'when assigning values' do
      
      let(:draft) do
        region.draft
      end
      
      before do
        region.deploy!
        region.content = 'new content'
      end
      
      it 'assigns them to the draft' do
        draft.read_property(:content)
          .should eq 'new content'
      end
      
      it 'does not assign them to the model' do
        region.content
          .should eq 'live content'
      end
      
      it 'assigns to the draft_* attribute' do
        region.draft_content
          .should eq 'new content'
      end
    end
  end
  
  describe 'previewing changes' do
    
    before do
      region.deploy!
      region.content = 'new content'
    end
    
    context 'when in preview mode' do
    
      before do
        region.preview!
      end
    
      it 'makes the model readonly' do
        region.readonly?
          .should be_true
      end
    
      it 'blocks model deletion' do
        expect{ region.destroy }
          .to raise_error
      end
    
      it 'blocks assigning to draft attributes' do
        expect{ region.content = 'test' }
          .to raise_error
      end
      
      it 'renders the draft content' do
        region.content
          .should eq 'new content'
      end
    end
    
    
    context 'when not in preview mode' do
      
      it 'renders the original content' do
        region.content
          .should eq 'live content'
      end
    end
  end
end