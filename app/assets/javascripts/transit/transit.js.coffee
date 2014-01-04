#= require_self
#= require transit/editor
#= require jquery_ujs

@Transit ||= 
  config: 
    autoHideFlash: true
  configure:(key, value)->
    @config[key] = value