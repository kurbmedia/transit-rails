#= require ../dependencies/underscore
#= require ../dependencies/proper

class Editor extends Proper

editInstance = null

@Transit.basicEdit = (node)->
  Transit.basicEditor ||= new Editor()
  $(node).each (i, el)->
    field = $(el)
    return true if field.hasClass('transit-editor')
    
    field.wrap('<div class="transit-editor"></div>')
      .addClass('transit-editor')
    editor = field.parent('div.transit-editor')
    editor.prepend("<div class='editor-content'></div>")
    content = editor.find("> div.editor-content")
    content.html( field.val() )
      .height( field.height() )
    field.closest('form').on 'submit', (event)->
      $('div.transit-editor div.editor-content').trigger('blur')
    true  


$(document).on 'mouseenter mouseleave', 'div.transit-editor', (event)->
  if event.type is 'mouseenter' then $(event.currentTarget).addClass('current')
  else $(event.currentTarget).removeClass('current')

$(document).on 'click', 'div.transit-editor div.editor-content', (event)->
  editor = $(event.currentTarget)
  return true if editor == editInstance
  Transit.basicEditor.activate(editor, 
    placeholder: "<p>Enter your text</p>",
    controlsTarget: editor.parent('div.richtext-editor')
  )
  editInstance = editor


$(document).on 'blur', 'div.transit-editor div.editor-content', (event)->
  editor = $(event.currentTarget)
  unless editor.parent('div.transit-editor').hasClass('current')
    editor.trigger('changed.editor')
    field  = editor.next('textarea.transit-editor')
    wrap   = $("<div></div>")
    wrap.html(Transit.basicEditor.content())
    wrap.find('p').each (i, el)->
      para = $(el)
      if $.trim(para.text()) == ''
        para.remove()
    wrap.find('[style]').each (i, el)-> $(el).removeAttr('style')
    editor.html( wrap.html() )
    field.val( wrap.html() )
    
    Transit.basicEditor.deactivate()
    editInstance = null