require 'rails_helper'

describe "the Ordering extension" do
  
  before do
    Transit::Page.class_eval do
      transit :orderable
    end
  end
  
  context 'when included' do
    
    it 'adds a position field' do
      expect(Transit::Page.new.respond_to?(
        :position)).to be_truthy
    end
  end
  
  after do
    Transit::Page.destroy_all
  end
  
  let!(:page) do
    create(:page)
  end
  
  let!(:page2) do
    create(:page)
  end
  
  let!(:page3) do
    create(:page)
  end
  
  let!(:sub) do
    create(:page, parent: page)
  end
  
  let!(:sub2) do
    create(:page, parent: page)
  end
  
  let!(:sub3) do
    create(:page, parent: page)
  end
  
  context 'when top level nodes' do
    
    it 'increments position from existing nodes' do
      page.reload.position
        .should eq 1
    end
    
    it 'adds nodes in ascending order' do
      page2.reload.position
        .should eq 2
    end
  end
  
  context 'when nested nodes' do
    
    it 'adds nodes in ascending order' do
      sub.position
        .should eq 1
    end
    
    it 'sets the position to an incrementing value' do
      sub2.position
        .should eq 2
    end
  end
  
  describe 'reordering nodes with reposition!' do
    
    context 'when top level nodes' do
      
      before do
        page2.reposition!(1)
      end
      
      it 're-orders the node to the new position' do
        page2.reload.position
          .should eq 1
      end
      
      it 're-orders sibling nodes to higher positions' do
        page.reload.position
          .should eq 2
      end
    end
    
    context 'when nested nodes' do
      
      before do
        sub2.reposition!(1)
      end
      
      it 're-orders the node to the new position' do
        sub2.reload.position
          .should eq 1
      end
      
      it 'moves sibling nodes to higher positions' do
        sub.reload.position
          .should eq 2
        sub3.reload.position
          .should eq 3
      end
      
      it 'does not move other nodes outside of siblings' do
        page.reload.position
          .should eq 1
        page2.reload.position
          .should eq 2
      end
    end
  end
end