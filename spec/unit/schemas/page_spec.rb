require 'spec_helper'

describe 'Page Schemas' do
  
  let!(:page) do
    Transit::Page.new
  end
  
  it 'modifies the engine models' do
    page.respond_to?(:title)
      .should be_true
  end
  
  
end