require 'spec_helper'

describe 'The Sluggable extension' do
  
  before do
    Transit::Page.class_eval do
      transit :sluggable => ":month/:year/:title"
    end
  end
  
  let(:page) do
    Transit::Page.make!(
      available_on: Date.today,
      title: "Post Slug Test",
      available: true,
      slug: nil
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