#= require mercury/mercury
#= require_self
#= require ./ext
#= require ./ui/flash

@Mercury.Region::serialize = ->
  type: @type()
  data: @dataAttributes()
  content: @content(null, true)
  snippets: @snippets()

class @Transit.Editor extends @Mercury.PageEditor
  constructor:->
    super
    if Transit.config.snippets && Transit.config.snippets.optionsUrl
      $.extend Mercury.config.snippets, Transit.config.snippets

  editURL: null
    
  save: (callback) ->
    url = @saveUrl ? Mercury.saveUrl ? @iframeSrc()
    data = @serialize()
    data = { page: { region_data: data } }

    if @options.saveMethod == 'POST'
      method = 'POST'
    else
      method = 'PUT'
      data['_method'] = method

    Mercury.log('saving', data)
    
    doFlash = (xhr)->
      flash = xhr.getResponseHeader('X-Flash-Messages')
      return false unless flash
      list = $.parseJSON(flash)
      for item in list
        Transit.showFlash(type, msg) for type, msg of item

    options = 
      headers: Mercury.ajaxHeaders()
      type: method
      dataType: @options.saveDataType
      data: data
      success: (response, type, xhr) =>
        doFlash(xhr)
        Mercury.changes = false
        Mercury.trigger('saved', response)
        callback() if typeof(callback) == 'function'
      error: (response) =>
        Mercury.trigger('save_failed', response)
        Mercury.notify('Mercury was unable to save to the url: %s', url)

    if @options.saveStyle != 'form'
      options['data'] = jQuery.toJSON(data)
      options['contentType'] = 'application/json'
    jQuery.ajax url, options