require 'spec_helper'

describe Transit::Models::Page do
  
  it 'delivers as a page' do
    Page.delivery_type
      .should eq :page
  end
  
  it 'applies the page model' do
    Page.included_modules
    .should include(
    Transit::Models::Page)
  end
  
  it 'applies the ordering extension' do
    Page.included_modules
      .should include(
      Transit::Extensions::Ordered)
  end
  
  describe 'applied attributes' do
    
    let!(:page) do
      Page.new
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

    let(:page) do
      Page.new
    end

    it 'validates that a title exists' do
      page.should have(1)
        .errors_on(:title)
    end
    
    it 'validates that a name exists' do
      page.should have(1)
        .errors_on(:name)
    end
    
    it 'validates the presence of a slug' do
      Page.should validate_presence_of(
        :slug)
    end
  end
  
  describe 'generated_slugs' do
    
    let(:page) do
      Page.make(
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
    
    describe '.top_level' do
    
      it "only finds pages that do not belong to another" do
        Page.top_level.count
          .should eq 1
      end
    end
    
    describe '.from_path' do
      
      let(:path) do
        "parent/child"
      end
      
      it 'accepts a url and finds pages by path' do
        Page.from_path(path).first
          .should eq sub_page
      end
    end
  end
  
  describe 'page hierarchy' do
    
    let!(:page) do 
      Page.make!(
        title: "Parent Page",
        slug: "parent")
    end
    
    let!(:sub_page) do
      Page.make!(
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
            .should be_a(Page)
        end
        
        it "stores unique page instances" do
          page.children.count
            .should eq 1
        end
        
        it "creates full_path using only its slug" do
          page.full_path
            .should eq 'parent'
        end
        
        it 'creates absolute_path using only its slug' do
          page.absolute_path
            .should eq '/parent'
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
      
      it "creates full_path using the slug from its parent" do
        sub_page.full_path
          .should eq 'parent/sub-page'
      end
        
      it 'creates absolute_path using the slug from its parent' do
        sub_page.absolute_path
          .should eq '/parent/sub-page'
      end
    end
    
    context "when a page is tertiary" do
      
      let!(:tertiary) do
        Page.make!(
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
      
      it "creates a full path to the page" do
        tertiary.full_path
          .should eq "parent/sub-page/tertiary"
      end
      
      it "stores all parent paths in the slug_map array" do
        tertiary.slug_map
          .should eq [page, sub_page, tertiary]
          .collect(&:slug)
      end
    end
    
    describe "slug de-duplication" do
      
      context "when a child page's slug contains the parent" do
        
        let!(:secondary) do
          Page.make!(
            parent: page, 
            title: "Dupetest Page", 
            slug: 'parent/dupetest')
        end
        
        it "removes the parent's slug from the child" do
          secondary.full_path
            .should eq "parent/dupetest"
        end
      end
      
      context "when a child page's slug does not contain a parent" do
        
        let(:nodupe) do
          Page.make!(
            parent: page, 
            title: "Dupetest2",
            slug: slug
          )
        end
        
        let!(:slug) do
          'random-page/dupetest'
        end
        
        it "does not modify the slug" do
          nodupe.full_path
            .should eq "parent/random-page/dupetest"
        end
      end
    end
    
  end
end