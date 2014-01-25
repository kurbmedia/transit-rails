@Mercury.modalHandlers.pageDetails = 
  initialize:->
    that = @
    @element.find('form').attr('data-remote', 'true')
      .one 'ajax:complete', (event, xhr, status)->
        flash = xhr.getResponseHeader('X-Flash-Messages')
        return false unless flash
        list = $.parseJSON(flash)
        for item in list
          Transit.showFlash(type, msg) for type, msg of item
        that.hide()