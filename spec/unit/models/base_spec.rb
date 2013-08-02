require 'spec_helper'

describe "Deliverable models" do
  
  let!(:model) do
    Post.new
  end
  
  it 'has a content attribute' do
    model.respond_to?(:content)
      .should be_true
  end
  
  it 'has a content_schema attribute' do
    model.respond_to?(
      :content_schema)
      .should be_true
  end
end