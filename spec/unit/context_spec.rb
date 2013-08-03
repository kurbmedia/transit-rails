require 'spec_helper'

describe Transit::Context do
  
  let!(:heading) do
    Transit::Context.new(
      "type"    => "Heading",
      "content" => "Title",
      "node"    => "h1"
    )
  end
  
  let!(:body) do
    Transit::Context.new(
      "type"    => "TextBlock",
      "content" => "<p>test</p>"
    )
  end
  
  describe '.to_s' do
    
    context 'when the context is a node' do
      
      it 'wraps the content in the node' do
        heading.to_s.should(
          eq "<h1>Title</h1>")
      end
    end
    
    context 'when the context is not a node' do
      
      it 'returns the content' do
        body.to_s.should(
          eq "<p>test</p>")
      end
    end
  end
end