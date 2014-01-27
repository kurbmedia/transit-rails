## 
# Setup default configuration options
# 
Transit.setup do |config|
  
  ##
  # Method used for authentication in controllers. Before any 
  # actions are called within the Pages/Posts controller, this 
  # method will be run. It is best to define this method in 
  # your ApplicationController. By default it uses devises' convention 
  # of user_signed_in?
  # 
  # 
  config.authentication_method = :authenticate_user!
  

  ##
  # Allow for disabling built-in model validations
  # 
  config.enable_validations = true
  
  
  ##
  # Enable the media browser
  # 
  config.enable_media = true
  
  
  ##
  # Enable snippet support
  # 
  config.enable_snippets = true
  
  
  ##
  # Regular expression for finding audio files based on mimie type
  # 
  config.audio_regexp = %r{^(audio)/.*$}
  
  
  ##
  # When true, sub-pages will inherit their parent slug/url.
  # 
  config.inherit_parent_slugs = true
  
  
  ##
  # Regular expression for finding images based on mime type
  #   
  config.image_regexp = %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$}
  
  
  ##
  # Regular expression for finding videos based on mime type
  # 
  config.video_regexp = %r{^(video)/.*$}
  

  ##
  # When using the active extension, should a active_date be used?
  # 
  config.publish_with_date = true
  
  
  ##
  # Set a restriction on how deep menus can go.
  # 
  config.menu_depth = 3
  
  
  ##
  # When generating slugs, use this as the default interpolation
  # 
  config.sluggable_via = ":name"
  
  
  # Enable translations globally
  config.translate = false
  
  
  ##
  # Contains a list of template names that are available
  # 
  config.templates = []
end