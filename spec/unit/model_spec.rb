require 'spec_helper'

describe Transit::Model do
  
  describe '.transit' do
    
    context 'when called on a model' do

      it 'adds a delivery_options attribute' do
        Transit::Page.respond_to?(
          :delivery_options
        ).should be_true
      end
    
      it 'includes options passed from deliver_as' do
        TestPage.delivery_options
          .slugged.should eq ":name"
      end
      
      it 'loads additional extensions from the options hash' do
        Transit::Page.included_modules
          .should include(Transit::Extensions::Publishable)
      end
      
      mongoid_models_only do
        context 'when translate: true is passed' do
          
          it 'adds localize: true to fields' do
            Transit::Page.new
              .respond_to?(:name_translations)
              .should be_true
          end
        end
      end

    end
  end
end