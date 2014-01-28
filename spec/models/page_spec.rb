require 'spec_helper'

describe Transit::Page do
  
  describe 'associations' do
    
    
    it 'has many attachments' do
      should have_many(
        :attachments)
    end
  end
  
  describe 'applied attributes' do
    
    let!(:page) do
      Transit::Page.new
    end
    
    it 'has a title attribute' do
      page.respond_to?(:title)
        .should be_true
    end
    
    it 'has a description attribute' do
      page.respond_to?(:description)
        .should be_true
    end
  end
  
  describe "validations" do
    
    it 'validates that a title exists' do
      should validate_presence_of(
        :title)
    end
    
    it 'validates that a name exists' do
      should validate_presence_of(
        :name)
    end
    
    it 'validates the presence of a slug' do
      should validate_presence_of(
        :slug)
    end
  end
  
  describe 'sanitizing_slugs' do
    
    let(:page) do
      Transit::Page.make!(
        title: "Test Page",
        slug: slug
      )
    end
    
    context 'when the slug is a full url' do
      
      let!(:slug) do
        "http://somedomain.com/the-path"
      end
      
      it 'removes the protocol and domain' do
        page.slug
          .should eq "the-path"
      end
    end
    
    
    context 'when the slug contains leading slashes' do
      
      let!(:slug) do
        "//the-path"
      end
      
      it 'sanitizes the resulting slug' do
        page.slug
          .should eq "the-path"
      end
    end
  end
  
  describe 'page scopes' do
    
    let!(:parent_page) do
      Transit::Page.make!(
        title: "Un-Published Page",
        slug: "parent"
      )
    end
    
    let!(:sub_page) do
      Transit::Page.make!(
        title: 'Published Page', 
        slug: 'child',
        parent: parent_page)
    end
    
    describe '.top_level' do
    
      it "only finds pages that do not belong to another" do
        Transit::Page.top_level.count
          .should eq 1
      end
    end
  end
  
  describe 'page hierarchy' do
    
    let!(:page) do 
      Transit::Page.make!(
        title: "Parent Page",
        slug: "parent")
    end
    
    let!(:sub_page) do
      Transit::Page.make!(
        title: "Sub Page", 
        slug: "sub-page", 
        published: true,
        parent: page)
    end
    
    context 'when a page is top level' do
      
      context 'and it contains sub-pages' do
        
        it ".pages? returns true" do
          page.pages?
            .should be_true
        end
        
        it "stores sub pages as instances of the same class" do
          page.children.first
            .should be_a(Transit::Page)
        end
        
        it "stores unique page instances" do
          page.children.count
            .should eq 1
        end
      end
      
      context 'and it does not have sub-pages' do
        
        it ".pages? returns false" do
          sub_page.pages?
            .should be_false
        end
      end
    end
    
    context 'when a page is secondary' do
      
      it 'does not store parent page ids' do
        sub_page.children
          .should be_empty
      end
    end
    
    context "when a page is tertiary" do
      
      let!(:tertiary) do
        Transit::Page.make!(
          title: "Tertiary Page", 
          slug: 'tertiary',
          parent: sub_page)
      end
      
      it "is nested under the secondary page" do
        sub_page.children
          .should include(tertiary)
      end
      
      it "is not referenced in the top level page" do
        page.children
          .should_not include(tertiary)
      end
      
      it "stores unique page instances" do
        sub_page.children.count
          .should eq 1
      end
    end
    
    
    describe 'assigning a hash to region_data' do
      
      let!(:page) do
        Transit::Page.make!
      end
      
      before do
        page.update_attributes({
          region_data: { "test_node" => { "content" => "original" }}
        })
      end
      
      it 'generates a collection of regions' do
        page.regions
          .should_not be_nil
      end
      
      specify do
        page.regions.first
          .should be_a(Transit::Region)
      end
      
      it 'generates a region for each item in the hash' do
        page.regions.count
          .should eq 1
      end
    end
  end
  
  describe 'absolute paths' do
    
    context 'when inheriting parent slugs' do
      
      before do
        Transit.config.inherit_parent_slugs = true
      end
      
      let!(:parent_page) do
        Transit::Page.make!(
          title: "Un-Published Page",
          slug: "parent"
        )
      end
    
      let!(:sub_page) do
        Transit::Page.make!(
          title: 'Published Page', 
          slug: 'child',
          parent: parent_page)
      end
      
      
      let!(:tertiary) do
        Transit::Page.make!(
          title: "Tertiary Page", 
          slug: 'tertiary',
          parent: sub_page)
      end
    
      context 'and the page is top level' do
      
        it 'creates an absolute_path using only its slug' do
          parent_page.absolute_path
            .should eq '/parent'
        end
        
        it 'generates the full_path' do
          parent_page.full_path
            .should eq 'parent'
        end
      end
    
      context 'and the page is secondary' do
      
        it 'creates an absolute_path using the slug from its parent' do
          sub_page.absolute_path
            .should eq '/parent/child'
        end
        
        it 'generates the full path' do
          sub_page.full_path
            .should eq 'parent/child'
        end
      end
      
      context 'and the page is tertiary' do
        
        it 'creates an absolute_path using its heirarchy' do
          tertiary.absolute_path
            .should eq '/parent/child/tertiary'
        end
        
        it 'generates the full path' do
          tertiary.full_path
            .should eq 'parent/child/tertiary'
        end
      end
            
      context 'and the slug includes a parent slug' do
        
        let!(:tertiary2) do
          Transit::Page.make!(
            title: "Tertiary Page", 
            slug: 'child/tertiary2',
            parent: sub_page)
        end
        
        it 'removes the duplicate slug portions' do
          tertiary2.absolute_path
            .should eq '/parent/child/tertiary2'
        end
        
        it 'generates the full path' do
          tertiary2.full_path
            .should eq 'parent/child/tertiary2'
        end
      end
    end
    
    
    context 'when not inheriting parent slugs' do
      
      before do
        Transit.config.inherit_parent_slugs = false
      end
      
      let!(:parent_page) do
        Transit::Page.make!(
          title: "Un-Published Page",
          slug: "parent"
        )
      end
    
      let!(:sub_page) do
        Transit::Page.make!(
          title: 'Published Page', 
          slug: 'child',
          parent: parent_page)
      end
      
      
      let!(:tertiary) do
        Transit::Page.make!(
          title: "Tertiary Page", 
          slug: 'tertiary',
          parent: sub_page)
      end
      
      context 'and the page is top level' do
      
        it 'creates an absolute_path using only its slug' do
          parent_page.absolute_path
            .should eq '/parent'
        end
      end
    
      context 'and the page is secondary' do
      
        it 'creates an absolute_path using only its slug' do
          sub_page.absolute_path
            .should eq '/child'
        end
      end
      
      context 'and the page is tertiary' do
        
        it 'creates an absolute_path using only its slug' do
          tertiary.absolute_path
            .should eq '/tertiary'
        end
      end
      
    end
  end
end