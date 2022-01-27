require 'rails_helper'

describe Transit::Model do
  
  describe '.transit' do
    
    before do
      Transit::Page.class_eval do
        transit :sluggable => ':name'
      end
    end
    
    context 'when called on a model' do

      it 'adds a delivery_options attribute' do
        expect(Transit::Page.respond_to?(
          :delivery_options
        )).to be_truthy
      end
    
      it 'includes options passed from deliver_as' do
        expect(Transit::Page.delivery_options
          .sluggable).to eq ":name"
      end
      
      it 'loads additional extensions from the options hash' do
        expect(Transit::Page.included_modules)
          .to include(Transit::Extensions::Sluggable)
      end
    end
  end
end