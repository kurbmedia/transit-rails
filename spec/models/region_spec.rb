require 'spec_helper'

describe Transit::Region do
  
  let!(:page) do
    Transit::Page.make!
  end
  
  describe 'associations' do
    
    when_active_record do
      
      it 'belongs_to a page' do
        should belong_to(
          :page)
      end
    end
    
    when_mongoid do
      
      it 'is embedded in a page' do
        should be_embedded_in(
          :page)
      end
    end
  end
  
  describe 'content drafts' do
    
    
  end
end