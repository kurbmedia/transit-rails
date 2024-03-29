require 'rails_helper'

describe Transit::Media do
  
  describe 'validations' do
    
    it 'requires a name' do
      should validate_presence_of(
        :name)
    end
  end
  
  
  describe "#files" do
    
    before do
      ['application', 'image', 'file'].each do |type|
        create(:media, media_type: type)
      end
    end
    
    it 'finds only files' do
      Transit::Media.files.count
        .should eq 2
    end
  end
  
  
  describe "identifying media types" do
    
    let!(:asset) do
      Transit::Media.new(attrs)
    end
    
    
    describe '.image?' do
      
      context 'when the file has a image mime type' do
        
        let!(:attrs) do
          { content_type: "image/jpeg" }
        end
        
        it 'returns true' do
          asset.image?
            .should be_truthy
        end
      end
      
      context 'when the file has a different mime type' do
        
        let!(:attrs) do
          { content_type: "video/mp4" }
        end
        
        it 'returns false' do
          asset.image?
            .should be_falsey
        end
      end
    end
    
    
    describe '.video?' do
      
      context 'when the file has a video mime type' do
        
        let!(:attrs) do
          { content_type: "video/mp4" }
        end
        
        it 'returns true' do
          asset.video?
            .should be_truthy
        end
      end
      
      context 'when the file has a different mime type' do
        
        let!(:attrs) do
          { content_type: "image/jpeg" }
        end
        
        it 'returns false' do
          asset.video?
            .should be_falsey
        end
      end
    end
    
    
    describe '.audio?' do
      
      context 'when the file has a audio mime type' do
        
        let!(:attrs) do
          { content_type: "audio/mp3" }
        end
        
        it 'returns true' do
          asset.audio?
            .should be_truthy
        end
      end
      
      context 'when the file has a different mime type' do
        
        let!(:attrs) do
          { content_type: "video/mp4" }
        end
        
        it 'returns false' do
          asset.audio?
            .should be_falsey
        end
      end
    end
  end
end