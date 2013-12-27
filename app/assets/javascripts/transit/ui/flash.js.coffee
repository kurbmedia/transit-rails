@Transit.showFlash = (type, message)->
  msg = $('<div></div>')
  msg.html("#{message} <span class='closer close'>&times;</span>")
    .addClass("flash-message #{type} flash-message-#{type} transit-flash-message")
    .prependTo('body')
  msg.on 'click', 'span.closer', (event)->
    msg.fadeOut('fast', (-> $(this).remove() ))