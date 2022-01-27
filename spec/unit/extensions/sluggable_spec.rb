require 'rails_helper'

describe 'The Sluggable extension' do
  
  before do
    Transit::Page.class_eval do
      transit :sluggable => ":month/:year/:title"
    end
  end
  
  let(:page) do
    create(:page, 
      publish_on: Date.new(2013, 12, 1),
      title: "Post Slug Test",
      published: true,
      slug: nil
    )
  end
  
  it 'generates a slug based on the slugged config' do
    page.slug.should eq "12/2013/post-slug-test"
  end
end