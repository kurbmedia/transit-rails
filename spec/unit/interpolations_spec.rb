require 'rails_helper'

describe Transit::Interpolations do
  
  let!(:page) do
    create(:page)
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
      expect(Transit::Interpolations[:test]).to_not be_nil
    end
    
    it 'should add the callback as an interpolation' do
      expect(Transit::Interpolations[:test]).to be_a(Method)
    end
    
    context 'when running the interpolation' do
      
      it 'replaces each key with the callback result' do
        expect(Transit::Interpolations.interpolate(":test", page))
          .to eq "success"
      end
      
      it 'passes any arguments to the interpolation block' do
        expect(Transit::Interpolations.interpolate(":page", page))
          .to eq page.title
      end
    end
  end
  
  describe 'built in interpolations' do
    
    before do
      page.stub(
        publish_on: Date.today,
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
      expect(result).to eq expected
    end
  end
end