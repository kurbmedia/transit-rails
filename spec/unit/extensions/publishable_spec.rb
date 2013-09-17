require 'spec_helper' 

describe "Publishing Extension" do
  
  let!(:page) do
    Transit::Page.make!(
      title: "Un-Published Page",
      slug: "parent"
    )
  end
  
  let!(:page2) do
    Transit::Page.make!(
      title: 'Published Page', 
      slug: 'child',
      parent: page)
  end
  
  it 'adds a published attribute' do
    page.respond_to?(
      :published)
      .should be_true
  end
  
  it 'includes the Publishable extension' do
    Transit::Page.included_modules
      .should include(Transit::Extensions::Publishable)
  end
  
  it 'adds a .published? method' do
    page.respond_to?(
      :published?)
      .should be_true
  end
  
  describe '.published scope' do
    
    let(:page_ids) do
      Transit::Page.published
        .all.collect(&:id)
    end
    
    before do
      page2.publish!
      page2.reload
    end
  
    it "does not find pages where published is false" do
      page_ids.should_not(
        include(page.id))
    end
  
    it 'finds pages where published is true' do
      page_ids.should(
        include(page2.id))
    end
    
    context 'when publishing by date' do
      
      before do
        Transit::Page.class_eval do
          transit :publishable => :date
        end
      end
      
      let!(:page) do
        Transit::Page.make!(
          publish_date: Date.today.to_time.midnight,
          title: "Post Slug Test",
          published: true
        )
      end
  
      let!(:page2) do
        Transit::Page.make!(
          publish_date: 5.days.from_now,
          title: "Unpublished Post",
          published: true
        )
      end
      
      let(:page_ids) do
        Transit::Page.published.pluck(:id).map(&:to_s)
      end
      
      it 'finds objects where the publish date is before today' do
        page_ids.should(
          include(page.id.to_s))
      end
      
      it 'does not find objects where publish_date is after today' do
        page_ids.should_not(
          include(page2.id.to_s))
      end
    end
  end
end