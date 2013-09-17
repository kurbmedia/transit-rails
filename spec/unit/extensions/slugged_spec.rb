require 'spec_helper'

describe 'The slugged extension' do
  
  before do
    Transit::Page.class_eval do
      transit :slugged => ":month/:year/:title"
    end
  end
  
  let(:page) do
    Transit::Page.make!(
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
    page.slug.should eq(
      [mo, year, page.title.to_slug].join("/"))
  end
end