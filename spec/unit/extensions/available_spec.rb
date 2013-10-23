require 'spec_helper' 

describe "Available Extension" do
  
  let!(:page) do
    Transit::Page.make!(
      title: "Un-Available Page",
      slug: "parent"
    )
  end
  
  let!(:page2) do
    Transit::Page.make!(
      title: 'Available Page', 
      slug: 'child',
      parent: page)
  end
  
  it 'adds a available attribute' do
    page.respond_to?(
      :available)
      .should be_true
  end
  
  it 'includes the Available extension' do
    Transit::Page.included_modules
      .should include(Transit::Extensions::Available)
  end
  
  it 'adds a .available? method' do
    page.respond_to?(
      :available?)
      .should be_true
  end
  
  describe '.available scope' do
    
    let(:page_ids) do
      Transit::Page.available
        .all.collect(&:id)
    end
    
    before do
      page2.available!
      page2.reload
    end
  
    it "does not find pages where available is false" do
      page_ids.should_not(
        include(page.id))
    end
  
    it 'finds pages where available is true' do
      page_ids.should(
        include(page2.id))
    end
    
    context 'when checking availability by date' do
      
      before do
        Transit::Page.class_eval do
          transit :available => :date
        end
      end
      
      let!(:page) do
        Transit::Page.make!(
          available_on: Date.today.to_time.midnight,
          title: "Post Slug Test",
          available: true
        )
      end
  
      let!(:page2) do
        Transit::Page.make!(
          available_on: 5.days.from_now,
          title: "Unavailable Post",
          available: true
        )
      end
      
      let(:page_ids) do
        Transit::Page.available.pluck(:id).map(&:to_s)
      end
      
      it 'finds objects where the available_on date is before today' do
        page_ids.should(
          include(page.id.to_s))
      end
      
      it 'does not find objects where available_on is after today' do
        page_ids.should_not(
          include(page2.id.to_s))
      end
    end
  end
end