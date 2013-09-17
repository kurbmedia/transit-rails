require 'spec_helper'

describe "the Ordering extension" do
  
  context 'when included' do
    
    it 'adds a position field' do
      Transit::Page.new.respond_to?(
        :position).should be_true
    end
  end
  
  after do
    Transit::Page.destroy_all
  end
  
  let!(:page) do
    Transit::Page.make!
  end
  
  let!(:page2) do
    Transit::Page.make!
  end
  
  let!(:page3) do
    Transit::Page.make!
  end
  
  let!(:sub) do
    Transit::Page.make!(parent: page)
  end
  
  let!(:sub2) do
    Transit::Page.make!(parent: page)
  end
  
  let!(:sub3) do
    Transit::Page.make!(parent: page)
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