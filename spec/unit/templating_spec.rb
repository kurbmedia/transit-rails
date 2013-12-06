require 'spec_helper'

describe Transit::Templating do
  
  
  describe 'available_templates' do
    
    it 'includes the default template in the config' do
      Transit::Page.available_templates
        .should include('default')
    end
  end
end