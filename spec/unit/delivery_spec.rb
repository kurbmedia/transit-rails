require 'spec_helper'

describe PagesController, :type => :controller do
  
  it 'adds a current_page method to controllers' do
    controller.protected_methods
      .should include(:current_page)
  end
  
  describe 'controller extensions' do

    before do
      Transit::Page.stub_chain(:where, :first)
    end
  
    it 'finds a Transit::Page by slug' do
      Transit::Page.should_receive(
        :where).once
      controller.send(:current_page)
    end
    
    describe 'template rendering' do
      render_views
      
      before do
        get :show, slug: '/page', format: :html
      end
      
      it 'finds the page template' do
        expect(response).to(
          render_template('default'))
      end
    
      it 'renders the page template' do
        response.body.should(
          include('Default Template'))
      end
    end
    
  end
end