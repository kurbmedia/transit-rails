#= require ./mercury
#= require_self
#= require ./ext

@Mercury.Region::serialize = ->
  region_type: @type()
  data: @dataAttributes()
  content: @content(null, true)
  snippets: @snippets()

class @Transit.Editor extends @Mercury.PageEditor
  save: (callback) ->
    url = @saveUrl ? Mercury.saveUrl ? @iframeSrc()
    data = @serialize()
    data = { page: { regions_attributes: data } }

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
      success: (response) =>
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