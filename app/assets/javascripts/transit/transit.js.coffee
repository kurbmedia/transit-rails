#= require_self
#= require transit/editor

@Transit ||= 
  config: 
    autoHideFlash: true
  configure:(key, value)->
    @config[key] = value