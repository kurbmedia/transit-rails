require 'spec_helper'

describe Transit::Models do
  
  describe '.deliver_as' do
    
    context 'when called on a model' do

      it 'adds a delivery_options attribute' do
        TestPost.respond_to?(
          :delivery_options
        ).should be_true
      end
      
      it 'extends the model with the specified type' do
        TestPost.included_modules.should(
          include(Transit::Models::Post))
      end
    
      it 'includes options passed from deliver_as' do
        TranslatedPost.delivery_options
          .translate.should be_true
      end
      
      it 'loads additional extensions from the options hash' do
        Page.included_modules
          .should include(Transit::Extensions::Published)
      end
      
      mongoid_models_only do
        context 'when translate: true is passed' do
          
          it 'adds localize: true to fields' do
            TranslatedPage.new
              .respond_to?(:name_translations)
              .should be_true
          end
        end
      end

    end
    
  end
  
  describe '.modify_delivery' do
    
    before do
      TestPost.modify_delivery do |conf|
        conf.slugged = ":year/:title"
      end
    end
    
    it 'updates the delivery_options for the model' do
      TestPost.delivery_options.slugged
        .should eq ":year/:title"
    end
  end
end