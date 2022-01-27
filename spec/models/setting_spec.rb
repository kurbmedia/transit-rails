require 'rails_helper' 

describe Transit::Setting do
  
  
  describe '.value' do
    
    let!(:pref) do
      create(:settings,
        key: "pref",
        value: 'false',
        value_type: 'boolean'
      )
    end
    
    it 'coerces the string value to its proper format' do
      pref.value
        .should be_a(FalseClass)
    end
  end
  
  
  describe 'before save' do
    
    context 'when value_type is an object' do
      
      let!(:pref) do
        create(:settings,
          key: 'fake_array',
          value: [1,2,3],
          value_type: 'object'
        )
      end
      
      before do
        pref.reload
      end
      
      it 'marshals the object into a string' do
        pref.send(:read_attribute, 'value')
          .should be_a(String)
      end
            
      it 'converts the stored value to the original object' do
        pref.value
          .should be_a(Array)
      end
    end
  end
  
  
  describe 'after save' do
    
    let!(:pref) do
      create(:settings,
        key: 'update_test',
        value: "testing",
        value_type: "string"
      )
    end
    
    it 'updates the global settings' do
      Transit.settings['update_test']
        .should eq 'testing'
    end
    

    context 'when the setting is changed' do
      
      before do
        pref.value = 'updated'
        pref.save
      end
      
      it 'updates the global settings' do
        Transit.settings['update_test']
          .should eq 'updated'
        Transit.setting('update_test')
          .should eq 'updated'
      end
    end
  end
  
  
  describe 'options' do
    
    context 'when a "conversion_method" option exists' do
      
      let!(:pref) do
        create(:settings,
          key: "pref",
          value: 'false',
          value_type: 'boolean',
          options: { conversion_method: 'to_i' }
        )
      end
      
      it 'converts the value using the option' do
        pref.value
          .should eq 0
      end
    end
  end
  
  
  describe 'array value types' do
    
    let!(:pref) do
      create(:settings,
        key: 'str_array',
        value: "1,2,3",
        value_type: 'array',
        options: { separator: ',' }
      )
    end
    
    it 'creates an array using the "separator" option' do
      pref.value
        .should be_a(Array)
      pref.value.should eq ['1','2','3']
    end
  end
  
  
  describe '#add_mapping!' do
    
    before do
      Transit::Setting.add_mapping!('money', :to_money)
    end
    
    it 'adds mappings to the value_mappings hash' do
      Transit::Setting.value_mappings.keys
        .should include('money')
    end
    
    it 'assigns the method to the value mapping' do
      Transit::Setting.value_mappings['money']
        .should eq :to_money
    end
  end
end