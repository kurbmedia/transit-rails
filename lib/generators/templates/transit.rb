# Use this file to configure any default / global options.
Transit.configure do |config|
  require 'transit/adapters/<%= options[:orm] %>'
  
  ##
  # Enable translations globally for all transit models.
  # 
  #config.translate = false

  ##
  # When generating page slugs, use this interpolation
  # 
  #config.sluggable_via = ":name"

  ##
  # When using the available extension, by default available state 
  # is determined by checking the value of the 'available' attribute 
  # as well as 'available_on'. Items are considered available if true, and the
  # available_on date is on or before the current date. Set this to false to only 
  # utilize the 'available' attribute.
  # 
  #config.publish_with_date = true
  
  ##
  # Set the template directory in which to look for templates.
  # 
  config.template_dir = 'transit/pages'
end