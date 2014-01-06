#= require mercury/mercury
#= require_self
#= require ./ext
#= require ./ui/flash
#= require ./ui/details
#= require ./ui/media_library

@Mercury.Region::serialize = ->
  type: @type()
  data: @dataAttributes()
  content: @content(null, true)
  snippets: @snippets()

doFlash = (xhr)->
  flash = xhr.getResponseHeader('X-Flash-Messages')
  return false unless flash
  list = $.parseJSON(flash)
  for item in list
    Transit.showFlash(type, msg) for type, msg of item

class @Transit.Editor extends @Mercury.PageEditor
  constructor:->
    super
    if Transit.config.snippets && Transit.config.snippets.optionsUrl
      $.extend Mercury.config.snippets, Transit.config.snippets

  editURL: null
  
  publish:(callback)->
    url = @publishURL || Transit.publishURL
    if url is undefined
      Mercury.notify('Please assign the publish url.')
    return false unless url
    options = 
      type: 'POST'
      contentType: 'application/json'
      dataType: 'json'
      success: (response, type, xhr)=>
        $('div.mercury-publish-button').hide()
        doFlash(xhr)

      error: (response)=>
        $('div.mercury-publish-button').show()
        
    jQuery.ajax url, options
      
    
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
        if response && response.published isnt undefined && response.published is false
          $('div.mercury-publish-button').show()
        else $('div.mercury-publish-button').hide()

      error: (response) =>
        Mercury.trigger('save_failed', response)
        Mercury.notify('Unable to save to the url: %s', url)

    if @options.saveStyle != 'form'
      options['data'] = jQuery.toJSON(data)
      options['contentType'] = 'application/json'
    jQuery.ajax url, options