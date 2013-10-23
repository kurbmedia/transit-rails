require 'spec_helper'

describe "Transit::Delivery", :type => :controller do
  
  controller(PagesController) do
  end
  
  subject do
    Transit::Page
  end
  
  it 'adds a current_page method to controllers' do
    controller.protected_methods
      .should include(:current_page)
  end
  
  before do
    Transit::Page.stub_chain(:where, :first)
  end
  
  it 'finds a Transit::Page by slug' do
    subject.should_receive(:where)
      .once
    controller.send(:current_page)
  end
  
end