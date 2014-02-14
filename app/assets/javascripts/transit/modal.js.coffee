##
# Initialize and render a modal.
#
@Transit.modal = (url, options = {}) ->
  box = new Transit.Modal(url, options)
  box.show()
  box


class @Transit.Modal extends Transit.Module
  @defaults:
    show: false
    backdrop: false
    keyboard: false

  constructor:(@url, @options = {})->
    that       = @
    @el        = jQuery('#transit_modal_window')
    @container = jQuery('#transit_modal_content')
    @title     = jQuery('#transit_modal_title')
    
    if @el.data('bs.modal') is undefined
      @el.modal(@constructor.defaults)
    
    # unbind events that may be tied to the node
    @el.off("#{evt}.bs.modal") for evt in ['hide', 'hidden', 'show', 'shown']
    @el.modal('hide')
    
    # Bind bs hide events to make sure our global event is called
    @el.on 'hide.bs.modal', @hide
    @
      
  
  ## 
  # Hide the modal window
  #
  hide: (event)=> 
    Transit.trigger('modal:hide', @)
    return @ if event and event.type is 'hide.bs.modal'  # If the hide was triggered by bs, don't call it again.
    @el.one 'hidden.bs.modal', (event)=>
      Transit.trigger('modal:hidden', @)
    @el.modal('hide')
    Transit.off 'resize', @resize
    @
    
  
  ##
  # Load @url into the modal
  #
  load: (url)=>
    url ||= @url
    @container.css('opacity', 0).load url, (data)=>
      Transit.trigger('modal:loaded', @)
      @url = url
      @resize()
      @container.css('opacity', '')
      @options.handler?.call(@)
  
  
  ##
  # Resize the modal to fit its content
  #
  resize: ()=>
    cwidth = @el.width()
    dialog = @el.find('div.modal-dialog')
    dialog.stop().animate({
      width: @container.outerWidth() + "px"
    }, 500, (-> Transit.trigger('modal:resized') ))
    
  
  
  ##
  # Set the modal title
  #
  setTitle: (text)=> @title.html( text )
    
  
  ##
  # Show the modal window
  #
  show: => 
    that = @
    Transit.trigger('modal:show', @)
    @el.one 'shown.bs.modal', (event)->
      Transit.trigger('modal:shown', that)

    @el.modal('show')
    Transit.on 'resize', @resize
    @load(@url) if @url
    @
  


# Prepare the modal

jQuery('#transit_modal_window').modal
  show: false
  backdrop: false
  keyboard: false