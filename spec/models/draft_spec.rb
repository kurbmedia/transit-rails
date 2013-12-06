require 'spec_helper'

describe Transit::Draft do
  
  let!(:region) do
    Transit::Region.make(
      content: 'test content'
    )
  end
  
  let!(:page) do
    Transit::Page.make!(
      regions: [region]
    )
  end
end