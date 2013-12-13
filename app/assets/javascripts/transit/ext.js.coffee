@Transit.Editor::initializeInterface = ->
  @focusableElement = jQuery('<input>', {class: 'mercury-focusable', type: 'text'}).appendTo(@options.appendTo ? 'body')

  @iframe = jQuery('<iframe>', {id: 'mercury_iframe', name: 'mercury_iframe', class: 'mercury-iframe', frameborder: '0', src: 'about:blank'})
  @iframe.appendTo(jQuery(@options.appendTo).get(0) ? 'body')

  @toolbar = new Mercury.Toolbar(jQuery.extend(true, {}, @options, @options.toolbarOptions))
  @statusbar = new Mercury.Statusbar(jQuery.extend(true, {}, @options, @options.statusbarOptions))
  @resize()

  @iframe.one 'load', => @bindEvents()
  @iframe.on 'load', => @initializeFrame()

@Transit.Editor::resize = ->
  width  = jQuery(window).width()
  height = jQuery(window).height()
  toolbarHeight = @toolbar.top() + Math.floor(@toolbar.height())

  Mercury.displayRect = {top: toolbarHeight, left: 0, width: width, height: height - toolbarHeight, fullHeight: height}
  @iframe.css(top:toolbarHeight, left: 0, height: height - toolbarHeight)
  Mercury.trigger('resize')
  
@Transit.behaviors = {}

@Transit.behaviors.editForm = ()->
  Mercury.modal(Transit.editURL + "?mercury=true", { title: "Page Details", fullHeight: false, minWidth:600, minHeight:385, handler: 'editForm' });

@Transit.behaviors.mediaLibrary = (selection)->
  Mercury.modal("/admin/modals/assets.html?resource_type=#{Transit.Deliverable.type}&resource_id=#{Transit.Deliverable.id}", 
    { title: 'Files and Images', fullHeight: false, minWidth:600, handler: 'manageAssets'  })
    
@Mercury.modalHandlers.editForm = {
  initialize:->
    
  initializeForm:->
}