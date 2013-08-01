## 
# Setup default configuration options
# 
module Transit
  
  # Enable translations globally
  config.translate = false

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
  config.slug_posts_via = ":title"
  
  ##
  # When using the publishing extension, should a publish_date be used?
  # 
  config.publish_with_date = true

end