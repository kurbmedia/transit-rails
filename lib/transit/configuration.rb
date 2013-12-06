## 
# Setup default configuration options
# 
module Transit
  
  # Enable translations globally
  config.translate = false

  ##
  # Allow for disabling built-in model validations
  # 
  config.enable_validations = true

  ##
  # Method used for authentication in controllers. Before any 
  # actions are called within the Pages/Posts controller, this 
  # method will be run. It is best to define this method in 
  # your ApplicationController. By default it uses devises' convention 
  # of user_signed_in?
  # 
  # 
  config.authentication_method = :user_signed_in?
  
  ##
  # When generating post slugs, use this interpolation
  # 
  config.sluggable_via = ":name"
  
  ##
  # When using the active extension, should a active_date be used?
  # 
  config.publish_with_date = true
  
  
  ##
  # Contains a list of template names that are available
  # 
  config.templates = []
end