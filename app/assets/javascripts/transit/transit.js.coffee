# ----------------------------------------
# Require all dependencies
# ----------------------------------------

#= require ./bootstrap
#= require ./dependencies/resize_events
#= require ./dependencies/inflections

#= require_self

#= require ./component
#= require ./plugin
#= require ./modal
#= require ./validators
#= require ./interface
#= require ./components/button
#= require ./components/menu

# A couple basic jQuery extensions

jQuery.click = jQuery.click || do -> 
  if 'ontouchstart' in window then 'touchend' else 'click'

# General event functionality

Events =
  
  ##
  # Remove a global event listener
  #
  off: (name, callback) -> 
    jQuery(window).off("transit:#{name}", callback)
  
  
  ##
  # Add a global event listener
  #
  on: (name, callback) ->  
    jQuery(window).on("transit:#{name}", callback)

  
  ##
  # Add a global event listener to only be fired once
  #
  one: (name, callback) -> 
    jQuery(window).one("transit:#{name}", callback)


  ##
  # Trigger a global event
  #
  trigger: (name, options...) -> 
    jQuery(window).trigger("transit:#{name}", options)


# Log Functionality
# Extracted as an object so other classes can include it.
  
Logger = 
  ##
  # Global logger
  #
  log: (args...)->
    return true unless Transit.config?.debug
    console?.debug?(args...)
  
  
  ##
  # Performs a console.warn
  #
  warn: (msg)->
    return true unless Transit.config?.debug
    console?.warn?("Transit: #{msg}")
  
  
  ##
  # Display an error to the user. Uses console.error if available.
  #
  error: (msg)->
    return true unless Transit.config?.debug
    console?.error?("Transit: #{msg}")




# Module functionality extracted from Spine.js
# https://github.com/spine/spine

moduleKeywords = ['included', 'extended']

class Module
  
  ##
  # Include the features/properties of an object into this one
  #
  @include: (obj) ->
    throw new Error('include(obj) requires obj') unless obj
    for key, value of obj when key not in moduleKeywords
      @::[key] = value
    obj.included?.apply(this)
    this

  
  ##
  # Add 'class' level attributes to an object.
  #
  @extend: (obj) ->
    throw new Error('extend(obj) requires obj') unless obj
    for key, value of obj when key not in moduleKeywords
      @[key] = value
    obj.extended?.apply(this)
    this




# Base class/object

class @Transit extends Module
  @defaults:
    debug: false
  
  @include Events
  @include Logger
  
  version: "0.1.0"
  
  Components: Transit.Components || {}
  Handlers: Transit.Handlers || {}
  Plguns: Transit.Plugins || {}
  
  initialized: false
  
  constructor:->
    @iframe  = $('#transit_iframe')
    @iframe.on('load', @initFrame)
    
  
  ##
  # Closes the interface and redirects to the 
  # current url of the iframe.
  #
  close: ()->
    return true unless @iframe
    src = @iframe.attr('src')
    window.location.href = src || "/"

  
  
  ##
  # Initialize the UI
  #
  init: (config = {})=>
    return @ if @initialized
    @config = jQuery.extend(true, @constructor.defaults, config)
    
    # Create the primary toolbar    
    @UI ||= new @Interface( jQuery('#transit_primary_toolbar') )
    
    @refresh()
    
    jQuery(window)
      .off('resizestart.transit')
      .off('resizestop.transit')
      .on('resizestop.transit', @refresh)

    @initialized = true
    @trigger('init')
    @
  
  
  ##
  # Initialize the frame
  #
  initFrame:(event)=>
    return true unless @initialized

    @trigger('load', @)
    @doc = jQuery(@iframe.get(0).contentWindow.document)
    
    that = @
    
    # Assign jQuery to the child window, unless it exists already
    # then trigger the ready event for any custom initialization
    
    @win = @iframe.get(0).contentWindow
    @win.jQuery = @win.jQuery || jQuery
    @win.jQuery(@win).trigger('ready')

    @win.Transit = @
    
    # @win.jQuery(@win).one "beforeunload.transit", (event)->
    #   that.trigger('unload')
    
    @refresh()
    @trigger('ready', { editor: @, frame: @ })
    @
  
  
  ##
  # Load a url into the iframe.
  #
  load:(url = null)=>
    return false unless url 
    @url = url
    @trigger('unload')
    @iframe.attr('src', @url)
    @
 
  
  ##
  # Render a new set of nodes/elements into the toolbar. 
  #
  render:( conf = {} )=>
    @UI.render( conf )
    
  
  
  ##
  # Refresh and re-position elements as necessary
  #
  refresh:(event)=> 
    return true unless @initialized
    @trigger('refresh')
    @iframe.css 
      top: @UI.el.height()
      height: jQuery(window).height() - @UI.el.height()
 


@Transit = new Transit()

@Transit.Logger = Logger
@Transit.Module = Module
@Transit.Events = Events