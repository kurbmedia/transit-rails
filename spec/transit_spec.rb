require 'spec_helper'

describe Transit do

  it 'has a version const' do
    Transit::VERSION
      .should_not be_nil
  end
  
  it 'has a configuration' do
    Transit.config
      .should_not be_nil
  end
  
  describe '.deliverables' do
    
    it 'is a hash' do
      Transit.deliverables
        .should be_a(Hash)
    end
    
    context 'when adding a deliverable' do
      
      before do
        Transit.add_deliverable(
          Post, :post)
      end
      
      it 'adds it to the hash' do
        Transit.deliverables[:post]
          .should be_an(Array)
      end
    end
  end
end