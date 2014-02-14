class @Transit.Components.Button extends @Transit.Component
  options:
    type: "default"
    label: "Button"
  
  
  ##
  # Bind button events
  #
  bindEvents:()=>
    
    # Handle click or touchend events
    @el.on "#{jQuery.click}.transit", (event)=>
      event.preventDefault()
      event.stopImmediatePropagation()
      @el.toggleClass('active') if @options.type is 'toggle'
      @handler?.call(@, event)
  
  
  ##
  # Build the button
  #
  build:=>
    super
    @el.addClass("transit-toolbar-button #{@name} transit-#{@name}-button")
    return @el unless @el.is(":empty")

    link = jQuery("<a></a>").attr('href', '#')
      .append( @buildIcon() )
      .append( jQuery('<span></span>').addClass('title').html( @options.label ) )
    @el.append(link)
    @el
    