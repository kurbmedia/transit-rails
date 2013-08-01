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
end