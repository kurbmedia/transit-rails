require 'spec_helper'

describe 'The slugged extension' do
  
  before do
    Post.modify_delivery do |conf|
      conf.slugged = ":month/:year/:title"
    end
  end
  
  let(:post) do
    Post.make!(
      post_date: Date.today,
      title: "Post Slug Test",
      published: true
    )
  end
  
  let(:year) do
    Date.today.year
  end
  
  let(:mo) do
    Date.today.strftime("%m")
  end 
  
  it 'generates a slug based on the slugged config' do
    post.slug.should eq(
      [mo, year, post.title.to_slug].join("/"))
  end
end