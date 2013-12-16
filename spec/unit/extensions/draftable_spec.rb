require 'spec_helper' 

describe "Draft Extension" do
  
  let!(:region) do
    Transit::Region.new(
      id: "test_region",
      content: "live content"
    )
  end
  
  let!(:rdata) do
    { 'test_region' => region.attributes }
  end
  
  let!(:page) do
    Transit::Page.make!(
      region_data: rdata
    )
  end
  
  
  let(:ndata) do
    { 'test_region' => { 'content' => 'draft' }}
  end
  
  
  it 'adds a deploy method' do
    page.respond_to?(:deploy)
      .should be_true
  end
  
  
  it 'includes the Draftable extension' do
    Transit::Page.included_modules
      .should include(Transit::Extensions::Draftable)
  end
  
  
  it 'configures draftable attributes' do
    page.send(:draftable_attributes)
      .should eq [:region_data]
  end
  
  it 'creates a Draft class for the model' do
    expect{ Transit::Page.const_get('Draft') }
      .to_not raise_error
  end
  
  describe 'model content' do
    
    context 'when assigning values' do
      
      let(:draft) do
        page.draft
      end
      
      before do
        page.deploy!
        page.region_data = ndata
      end
      
      it 'assigns them to the draft' do
        draft.read_property(:region_data)
          .should eq ndata
      end
      
      it 'does not assign them to the model' do
        page.region_data
          .should eq rdata
      end
      
      it 'assigns to the draft_* attribute' do
        page.draft_region_data
          .should eq ndata
      end
    end
  end
  
  describe 'previewing changes' do
    
    before do
      page.deploy!
      page.region_data = ndata
    end
    
    context 'when in preview mode' do
    
      before do
        page.preview!
      end
    
      it 'makes the model readonly' do
        page.readonly?
          .should be_true
      end
    
      it 'blocks model deletion' do
        expect{ page.destroy }
          .to raise_error
      end
    
      it 'blocks assigning to draft attributes' do
        expect{ page.region_data = ndata }
          .to raise_error
      end
      
      it 'renders the draft content' do
        page.region_data
          .should eq ndata
      end
    end
    
    
    context 'when not in preview mode' do
      
      it 'renders the original content' do
        page.region_data
          .should eq rdata
      end
    end
  end
end