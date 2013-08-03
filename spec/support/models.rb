if TRANSIT_ORM == 'mongoid'
  class TestPost
    include Mongoid::Document
    include Mongoid::Timestamps
  
    deliver_as :post
  end
  
  class TestPage
    include Mongoid::Document
    include Mongoid::Timestamps
  
    deliver_as :page, :slugged => ":name"
  end
  
  class TranslatedPost
    include Mongoid::Document
    include Mongoid::Timestamps
    deliver_as :post, :translate => true
  end

  class TranslatedPage
    include Mongoid::Document
    include Mongoid::Timestamps
    deliver_as :page, :translate => true
  end
  
elsif TRANSIT_ORM == 'active_record'
  class TestPost < Post
    deliver_as :post
  end
  
  class TestPage < Page
    deliver_as :page, :slugged => ":name"
  end
  
  class TranslatedPage < Page
    modify_delivery do |c|
      c.translate = true
    end
  end
  
  class TranslatedPost < Post
    modify_delivery do |c|
      c.translate = true
    end
  end
end