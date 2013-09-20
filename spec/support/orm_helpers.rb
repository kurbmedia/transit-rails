module ORMHelpers
  def using_mongoid?
    TRANSIT_ORM == 'mongoid'
  end
  
  def using_active_record?
    TRANSIT_ORM == "active_record"
  end
  
  def mongoid_models_only(&block)
    block.call() if using_mongoid?
  end
  
  def when_active_record(&block)
    block.call if using_active_record?
  end
  
  def when_mongoid(&block)
    block.call if using_mongoid?
  end
  
end