require 'spec_helper'

describe Transit::Templating do
  
  
  describe 'available_templates' do
    
    it 'finds all templates in the templates_dir' do
      Transit::Page.available_templates
        .should eq ['default']
    end
  end
end