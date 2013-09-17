require 'spec_helper'

describe Transit::Model do
  
  describe '.transit' do
    
    before do
      Transit::Page.class_eval do
        transit :sluggable => ':name'
      end
    end
    
    context 'when called on a model' do

      it 'adds a delivery_options attribute' do
        Transit::Page.respond_to?(
          :delivery_options
        ).should be_true
      end
    
      it 'includes options passed from deliver_as' do
        Transit::Page.delivery_options
          .sluggable.should eq ":name"
      end
      
      it 'loads additional extensions from the options hash' do
        Transit::Page.included_modules
          .should include(Transit::Extensions::Publishable)
      end
    end
  end
end