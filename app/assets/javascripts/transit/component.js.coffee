##
# Base class to power a component. 
# Components are anything from buttons, to menus, forms etc... basically
# anything you can put in a bootstrap navbar.
#
class @Transit.Component extends Transit.Module
  keep: false
  type: "component"
  options:
    tag: "li"
    html: ""

  ##
  # Construct a new component
  #
  constructor:(@name, options = {})->

    @options = jQuery.extend(true, {}, @options, options)
    @el      = @options.el || @build()
    @keep    = jQuery.parseJSON(@options.keep.toString()) if @options.keep
    
    @assignHandler()
    @bindEvents()
    
    # Call an initializer function if it exists
    @init?()
    
    @
  
  
  addClass: (args...)=> @el.addClass(args...)
  
  
  ##
  # Assign the handler to this component
  #
  assignHandler:()=>
    return false unless @options.handler or @options.modal
    if @options.handler
      handler = @options.handler
      if jQuery.type( handler ) is 'string' 
        handler = Transit.Handlers[handler] 
        Transit.warn("The handler #{@options.handler} could not be found. No action will be called") if handler is undefined
        @handler = handler || jQuery.noop
      else @handler = @options.handler
    else if @options.modal
      props = @options.modal
      if jQuery.type( props ) is 'string' then @handler = (-> Transit.modal(props) )
      else @handler = (-> Transit.modal( props.url, props ))
    @
  
  
  ##
  # Bind any necessary events.
  # Override in subclasses
  #
  bindEvents: ()=> @
    
    
  ##
  # Builds and the html for the component, 
  # assigns the elements el from the result.
  #
  build:()=> 
    @beforeBuild?()  # Allow sub-components to perform actions before building
    
    @el ||= jQuery(document.createElement('li'))
    @el.html(@options.html) if @options.html

    @el.addClass( @options.classes ) if @options.classes
    @el.attr(@options.attributes) if @options.attributes
    
    @afterBuild?() # Allow sub-components to perform actions after building
    
    @el
  
  
  ##
  # Build an icon node for the component
  #
  buildIcon: ()=>
    return '' unless @options.icon
    jQuery("<i></i>")
      .addClass("fa fa-#{@options.icon}")
  
  
  ##
  # Delegate .css to the element
  #
  css: (args...)=> 
    jQuery.fn.css.apply(@el, args)
  
  
  ##
  # Destroy a component, unless its flagged to keep.
  # Allow forcing the component to remove no matter what.
  #
  destroy: ( force = false )=>
    return false if @keep and force is false
    @beforeDestroy?()
    @el.off().empty().remove()
    @afterDestroy?()
    true
  
  
  removeClass: (args...)=> @el.removeClass(args...)
    
    