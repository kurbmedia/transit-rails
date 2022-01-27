require 'rails_helper'

describe Transit do

  it 'has a version const' do
    expect(Transit::VERSION).to_not be_nil
  end
  
  it 'has a configuration' do
    expect(Transit.config).to_not be_nil
  end
  
  describe 'updating configuration' do
    
    context 'when Transit.setup is run' do
      
      before do
        Transit.setup do |conf|
          conf.authentication_method = :check_it!
        end
      end
      
      it 'updates config values' do
        expect(Transit.config.authentication_method).to eq :check_it!
      end
    end
  end
end