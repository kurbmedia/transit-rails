require 'rails_helper'

describe Transit::Page, type: :model do
  
  describe 'applied attributes' do
    
    let!(:page) do
      Transit::Page.new
    end

    it 'has a title and description' do
      expect(page.respond_to?(:title)).to be_truthy
      expect(page.respond_to?(:description)).to be_truthy
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
      create(:page, title: "Test Page", slug: slug)
    end
    
    context 'when the slug is a full url' do
      
      let!(:slug) do
        "http://somedomain.com/the-path"
      end
      
      it 'removes the protocol and domain' do
        expect(page.slug).to eq 'the-path'
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
      create(:page,
        title: "Un-Published Page",
        slug: "parent"
      )
    end
    
    let!(:sub_page) do
      create(:page,
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
      create(:page,
        title: "Parent Page",
        slug: "parent")
    end
    
    let!(:sub_page) do
      create(:page,
        title: "Sub Page", 
        slug: "sub-page", 
        published: true,
        parent: page)
    end
    
    context 'when a page is top level' do
      
      context 'and it contains sub-pages' do
        
        it ".pages? returns true" do
          expect(page.pages?).to be_truthy
        end
        
        it "stores sub pages as instances of the same class" do
          expect(page.children.first).to be_a(Transit::Page)
        end
        
        it "stores unique page instances" do
          expect(page.children.count).to eq 1
        end
      end
      
      context 'and it does not have sub-pages' do
        
        it ".pages? returns false" do
          expect(sub_page.pages?).to be_falsey
        end
      end
    end
    
    context 'when a page is secondary' do
      
      it 'does not store parent page ids' do
        expect(sub_page.children).to be_empty
      end
    end
    
    context "when a page is tertiary" do
      
      let!(:tertiary) do
        create(:page,
          title: "Tertiary Page", 
          slug: 'tertiary',
          parent: sub_page)
      end
      
      it "is nested under the secondary page" do
        expect(sub_page.children).to include(tertiary)
      end
      
      it "is not referenced in the top level page" do
        expect(page.children).to_not include(tertiary)
      end
      
      it "stores unique page instances" do
        expect(sub_page.children.count).to eq 1
      end
    end
    
    
    describe 'assigning a hash to region_data' do
      
      let!(:page) do
        create(:page)
      end
      
      before do
        page.update({
          region_data: { "test_node" => { "content" => "original" }}
        })
      end
      
      it 'generates a collection of regions' do
        expect(page.regions).to_not be_nil
      end
      
      specify do
        expect(page.regions.first).to be_a(Transit::Region)
      end
      
      it 'generates a region for each item in the hash' do
        expect(page.regions.count).to eq 1
      end
    end
  end
  
  describe 'absolute paths' do
    
    context 'when inheriting parent slugs' do
      
      before do
        Transit.config.inherit_parent_slugs = true
      end
      
      let!(:parent_page) do
        create(:page,
          title: "Un-Published Page",
          slug: "parent"
        )
      end
    
      let!(:sub_page) do
        create(:page,
          title: 'Published Page', 
          slug: 'child',
          parent: parent_page)
      end
      
      
      let!(:tertiary) do
        create(:page,
          title: "Tertiary Page", 
          slug: 'tertiary',
          parent: sub_page)
      end
    
      context 'and the page is top level' do
      
        it 'creates an absolute_path using only its slug' do
          expect(parent_page.absolute_path).to eq '/parent'
        end
        
        it 'generates the full_path' do
          expect(parent_page.full_path).to eq 'parent'
        end
      end
    
      context 'and the page is secondary' do
      
        it 'creates an absolute_path using the slug from its parent' do
          expect(sub_page.absolute_path).to eq '/parent/child'
        end
        
        it 'generates the full path' do
          expect(sub_page.full_path).to eq 'parent/child'
        end
      end
      
      context 'and the page is tertiary' do
        
        it 'creates an absolute_path using its heirarchy' do
          expect(tertiary.absolute_path).to eq '/parent/child/tertiary'
        end
        
        it 'generates the full path' do
          expect(tertiary.full_path).to eq 'parent/child/tertiary'
        end
      end
            
      context 'and the slug includes a parent slug' do
        
        let!(:tertiary2) do
          create(:page,
            title: "Tertiary Page", 
            slug: 'child/tertiary2',
            parent: sub_page)
        end
        
        it 'removes the duplicate slug portions' do
          expect(tertiary2.absolute_path).to eq '/parent/child/tertiary2'
        end
        
        it 'generates the full path' do
          expect(tertiary2.full_path).to eq 'parent/child/tertiary2'
        end
      end
    end
    
    
    context 'when not inheriting parent slugs' do
      
      before do
        Transit.config.inherit_parent_slugs = false
      end
      
      let!(:parent_page) do
        create(:page,
          title: "Un-Published Page",
          slug: "parent"
        )
      end
    
      let!(:sub_page) do
        create(:page,
          title: 'Published Page', 
          slug: 'child',
          parent: parent_page)
      end
      
      
      let!(:tertiary) do
        create(:page,
          title: "Tertiary Page", 
          slug: 'tertiary',
          parent: sub_page)
      end
      
      context 'and the page is top level' do
      
        it 'creates an absolute_path using only its slug' do
          expect(parent_page.absolute_path).to eq '/parent'
        end
      end
    
      context 'and the page is secondary' do
      
        it 'creates an absolute_path using only its slug' do
          expect(sub_page.absolute_path).to eq '/child'
        end
      end
      
      context 'and the page is tertiary' do
        
        it 'creates an absolute_path using only its slug' do
          expect(tertiary.absolute_path).to eq '/tertiary'
        end
      end
      
    end
  end
end