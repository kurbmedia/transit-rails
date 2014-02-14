class @Transit.Components.MenuItem extends @Transit.Component
  options:
    label: "Menu Item"
  
  
  ##
  # If a url is provided, let the link function normally, 
  # otherwise, bind a handler to it.
  #
  bindEvents:()=>
    return true if @options.url
    @link.on "#{jQuery.click}.transit", (event)=>
      event.preventDefault()
      Transit.trigger('menu:choose', @)
      @handler?.call(@, event)
  
  
  ##
  # Menu items can really only be built one way, override
  # build completely here.
  #
  build:()=>
    @el  = jQuery("<li></li>")
    @link = jQuery("<a></a>").text( @options.label )
    
    @link.attr(href: @options.url, target: 'transit_iframe') if @options.url
    @link.prepend( @buildIcon() )
    
    if @el.attr('id') is undefined
      @el.attr('id', "transit_menu_item_#{@name.underscore()}")
    
    @el.empty()
      .append( @link )
      .addClass( @name.underscore().dasherize() )