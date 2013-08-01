require 'spec_helper'

describe Transit::Models::Post do
  
  it 'delivers as a post' do
    Post.delivery_type
      .should eq :post
  end
  
  it 'applies the post model' do
    Post.included_modules
    .should include(
    Transit::Models::Post)
  end
  
  it 'applies the publishing extension' do
    Post.included_modules
      .should include(
      Transit::Extensions::Published)
  end
  
  describe 'applied attributes' do
    
    let!(:post) do
      Post.new
    end
    
    it 'has a title attribute' do
      post.respond_to?(:title)
        .should be_true
    end
    
    it 'has a teaser attribute' do
      post.respond_to?(:teaser)
        .should be_true
    end
  end
  
  describe 'validations' do
    
    let(:post) do
      Post.new
    end
    
    it 'validates a title exists' do
      post.should have(1)
        .errors_on(:title)
    end
  end
  
  describe 'generating slugs' do
    
    let!(:post) do
      Post.make!(
        title: "a sample post"
      )
    end
    
    context 'when the post is not published' do
      
      it 'does not generate a slug' do
        post.slug
          .should be_nil
      end
    end
    
    context 'when the post is published' do
      
      before do
        post.publish!
        post.reload
      end
      
      it 'generates a slug' do
        post.slug
          .should eq "a-sample-post"
      end
    end
  end
end