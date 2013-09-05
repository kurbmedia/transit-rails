require 'spec_helper' 

describe "Publishing Extension" do
  
  let!(:parent_page) do
    Page.make!(
      title: "Un-Published Page",
      slug: "parent"
    )
  end
  
  let!(:sub_page) do
    Page.make!(
      title: 'Published Page', 
      slug: 'child',
      parent: parent_page)
  end
  
  it 'adds a published attribute' do
    parent_page.respond_to?(
      :published)
      .should be_true
  end
  
  it 'adds a .published? method' do
    parent_page.respond_to?(
      :published?)
      .should be_true
  end
  
  describe '.published scope' do
    
    let(:page_ids) do
      Page.published
        .all.collect(&:id)
    end
    
    before do
      sub_page.publish!
    end
  
    it "does not find pages where published is false" do
      page_ids.should_not(
        include(parent_page.id))
    end
  
    it 'finds pages where published is true' do
      page_ids.should(
        include(sub_page.id))
    end
    
    context 'when publishing by date' do
      
      let!(:post) do
        Post.make!(
          publish_date: Date.today.to_time.midnight,
          title: "Post Slug Test",
          published: true
        )
      end
  
      let!(:post2) do
        Post.make!(
          publish_date: 5.days.from_now,
          title: "Unpublished Post",
          published: true
        )
      end
      
      let(:post_ids) do
        Post.published.pluck(:id).map(&:to_s)
      end
      
      it 'finds objects where the publish date is before today' do
        post_ids.should(
          include(post.id.to_s))
      end
      
      it 'does not find objects where publish_date is after today' do
        post_ids.should_not(
          include(post2.id.to_s))
      end
    end
  end
end