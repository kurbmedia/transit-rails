require 'spec_helper'

describe Transit::Schematic do
  
  let!(:page) do
    Page.make!(
    content_schema: schema)
  end
  
  let(:schema) do
    {
      "0" => { "type" => "Heading", "content" => "Title", "node" => "h1" },
      "1" => { "type" => "TextBlock", "content" => "<p>test</p>" }
    }
  end
  
  let(:content) do
    page.content_schema
  end
  
  describe 'serialization' do
    
    context 'initial state' do
      
      it 'is a Transit::Schematic' do
        Page.new.content_schema
          .should be_a(Transit::Schematic)
      end
    end
    
    context 'when saved' do
      
      it 'is a Transit::Schematic' do
        content
          .should be_a(Transit::Schematic)
      end
    end
  end
  
  describe '.content_types' do

    it 'is an array of the content types' do
      content.content_types
        .should eq(['Heading', 'TextBlock'])
    end
  end
  
  describe '.to_data' do

    it 'generates an array' do
      content.to_data
        .should be_an(Array)
    end
    
    it 'contains multiple ContentFields' do
      content.to_data.first
        .should be_a(Transit::ContentField)
    end
    
    it 'assigns attributes to each field' do
      content.to_data.first
        .type.should eq 'Heading'
    end
  end
end