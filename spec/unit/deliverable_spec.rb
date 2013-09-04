require 'spec_helper' 

describe Transit::Deliverable do
  
  it 'adds extension support to models' do
    Business.respond_to?(:delivery_as)
      .should be_true
  end
  
  context 'when extensions are added' do
    
    let(:biz) do
      Business.make!(
        name: "Business Name",
        summary: "This is the description"
      )
    end
    
    it 'properly extends delivery_options' do
      Business.delivery_options.slugged
        .should eq ':name'
    end

    it 'functions like an internal model' do
      biz.slug.should eq "business-name"
    end
  end
end