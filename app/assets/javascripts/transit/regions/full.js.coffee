@Mercury.Regions.Full::serialize = ->
  content = @content(null, true)
  holds = $(document.createElement('div'))
  holds.html(content).htmlClean()
  
  holds.find('div').each (i, el)->
    div  = $(el)
    para = $(document.createElement('p'))
    para.html(div.html())
    div.replaceWith( para )

  holds.find("p:empty").remove()
  holds.find('p').each (i, el)->
    para = $(el)
    if $.trim(para.text()) == "" && para.children().length == 0 
      para.remove()
  holds.find('span').each (i, el)->
    $(el).replaceWith( $(el).html() )
  content = holds.html()
  
  type: @type()
  data: @dataAttributes()
  content: content
  snippets: @snippets()