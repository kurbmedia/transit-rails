#= require mercury

class @Transit.Editor extends @Mercury.PageEditor
  initializeInterface: ->
    @focusableElement = jQuery('<input>', {class: 'mercury-focusable', type: 'text'}).appendTo(@options.appendTo ? 'body')

    @iframe = jQuery('<iframe>', {id: 'mercury_iframe', name: 'mercury_iframe', class: 'mercury-iframe', frameborder: '0', src: 'about:blank'})
    @iframe.appendTo(jQuery(@options.appendTo).get(0) ? 'body')

    @toolbar = new Mercury.Toolbar(jQuery.extend(true, {}, @options, @options.toolbarOptions))
    @statusbar = new Mercury.Statusbar(jQuery.extend(true, {}, @options, @options.statusbarOptions))
    @resize()

    @iframe.one 'load', => @bindEvents()
    @iframe.on 'load', => @initializeFrame()