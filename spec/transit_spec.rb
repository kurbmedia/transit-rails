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
end