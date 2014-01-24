require 'spec_helper'

describe Transit::Media do
  
  describe 'associations' do
    
    it 'belongs to an attachable resource' do
      should belong_to(
        :attachable)
    end
  end
  
  
  describe 'validations' do
    
    it 'requires a name' do
      should validate_presence_of(
        :name)
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
            .should be_true
        end
      end
      
      context 'when the file has a different mime type' do
        
        let!(:attrs) do
          { content_type: "video/mp4" }
        end
        
        it 'returns false' do
          asset.image?
            .should be_false
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
            .should be_true
        end
      end
      
      context 'when the file has a different mime type' do
        
        let!(:attrs) do
          { content_type: "image/jpeg" }
        end
        
        it 'returns false' do
          asset.video?
            .should be_false
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
            .should be_true
        end
      end
      
      context 'when the file has a different mime type' do
        
        let!(:attrs) do
          { content_type: "video/mp4" }
        end
        
        it 'returns false' do
          asset.audio?
            .should be_false
        end
      end
    end
  end
end