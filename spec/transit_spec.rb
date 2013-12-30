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
  
  describe 'updating configuration' do
    
    context 'when Transit.setup is run' do
      
      before do
        Transit.setup do |conf|
          conf.authentication_method = :check_it!
        end
      end
      
      it 'updates config values' do
        Transit.config.authentication_method
          .should eq :check_it!
      end
    end
  end
end