require 'spec_helper'

describe Transit::Interpolations do
  
  let!(:page) do
    Transit::Page.make
  end
  
  describe 'adding methods with Transit.interpolates' do

    before do
      Transit.interpolates(:test) do |model|
        "success"
      end
      
      Transit.interpolates(:page) do |model|
        model.title
      end
    end
    
    it 'should add an interpolation method' do
      Transit::Interpolations[:test]
        .should_not be_nil
    end
    
    it 'should add the callback as an interpolation' do
      Transit::Interpolations[:test]
        .should be_a(Method)
    end
    
    context 'when running the interpolation' do
      
      it 'replaces each key with the callback result' do
        Transit::Interpolations.interpolate(":test", page)
          .should eq "success"
      end
      
      it 'passes any arguments to the interpolation block' do
        Transit::Interpolations.interpolate(":page", page)
          .should eq page.title
      end
    end
  end
  
  describe 'built in interpolations' do
    
    before do
      page.stub(
        available_on: Date.today,
        title: 'sample title'
      )
    end
    
    let(:expected) do
      "#{Date.today.strftime('%m')}/#{Date.today.year}/#{page.title.to_slug}"
    end
      
    let(:result) do
      Transit::Interpolations
        .interpolate(":month/:year/:title", 
        page)
    end
      
    it "interpolates month, year, and title" do
      result.should eq expected
    end
  end
end