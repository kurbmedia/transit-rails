require 'spec_helper'

describe Transit::MediaFolder do
  
  describe 'associations' do
    
    it 'has many files' do
      should have_many(
        :files)
    end
  end
  
  
  describe 'validations' do
    
    it 'requires a name' do
      should validate_presence_of(
        :name)
    end
    
    context 'when a folder exists with the same name' do
      
      let!(:dir) do
        Transit::MediaFolder.make!(
          name: "Root"
        )
      end
      
      
      context 'and on the same level' do
      
        let(:sub) do
          Transit::MediaFolder.make(
            name: 'Root'
          )
        end
      
        it 'invalidates the name' do
          sub.should have(1)
            .errors_on(:name)
        end
      end
      
      
      context 'and on a different level' do
        
        let(:sub) do
          Transit::MediaFolder.make(
            name: 'Root',
            parent: dir
          )
        end
      
        it 'does not invalidate the name' do
          sub.should have(:no)
            .errors_on(:name)
        end
      end
      
    end
  end
  
  
  describe 'generating paths' do
    
    let!(:dir) do
      Transit::MediaFolder.make!(
        name: "Root"
      )
    end
    
    context 'when the folder is top level' do
      
      it 'creates a path for the folder' do
        dir.full_path
          .should eq "/root"
      end
    end
    
    
    context 'when the folder is nested' do
      
      let!(:sub) do
        Transit::MediaFolder.make!(
          name: "Sub",
          parent: dir
        )
      end
      
      it 'creates the path using the parent' do
        sub.full_path.should(
          eq('/root/sub')
        )
      end
    end
  end
end