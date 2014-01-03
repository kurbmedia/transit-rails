class Menu
  plist: null
  item_path: null
  
  constructor:( @node )->
    @list       = $('#menu_item_list')
    @plist      = $('#add_page_item ul.option-list')
    @item_path  = @node.data('item-path')
    $('#add_page_item').on 'click', 'button.action-button', @addPages
    $('body').on 'click', '#transit_menu_items li a.remove-item-link', @removeItem
    $('#add_custom_item').on 'click', 'button.action-button', @addCustom
    
    @list.on 'items:update', ()=>
      @list.sortable(handle: 'div.handle', onDrop: @sort, group: 'nested')
  
  ##
  # Add a menu item from a specific url
  #
  addCustom:(event)=>
    event.preventDefault()
    data = {}
    $('input, select', $('#add_custom_item')).each (i, fd)=>
      fd = $(fd)
      data[fd.attr('name')] = fd.val()
    $.ajax(
      method: "POST"
      url: @item_path
      data: { menu_items: JSON.stringify([data]) }
      dataType: "script"
      success: (->)
    )
  
  ##
  # Add one or more pages from the user's selection
  #
  addPages:(event)=>
    event.preventDefault()
    data = []
    @plist.find('input:checkbox').each (i, fd)=>
      return true unless $(fd).is(":checked")
      fd = $(fd)
      data.push(page_id: fd.val(), title: fd.data('title'), url: fd.data('url'))
      fd.removeAttr('checked')

    $.ajax(
      method: "POST"
      url: @item_path
      data: { menu_items: JSON.stringify(data) }
      dataType: "script"
      success: (->)
    )
    
  ##
  # Remove a menu item
  #
  removeItem:(event)=>
    event.preventDefault()
    link = $(event.currentTarget)
    item = link.parents('li').eq(0)
    item.find('input[rel="remove"]').val('1')
    item.slideUp('fast')
  
  
  ##
  # Set item positions
  #
  sort:(item, container, supa)=>
    supa(item)
    position = (pos, item)->
      li = $(item)
      li.find('input[rel="position"]').val( pos + 1 )
      if li.find('ul.sub').length isnt 0
        $('ul.sub > li', li).each( position )
          .find('> div.item input.parent').val( li.data('item-key') )
      
    @list.find('> li').each(position)
      
    
    
editMenu = ()->
  $('#transit_menu_select').on 'change', 'select', (event)->
    menuid = $(this).val()
    return true if $.trim(menuid) is ''
    $('#transit_menu_items').sortable("disable")
    $.getScript( [window.location.pathname.replace(/\/$/, ''), menuid].join("/") )
  

$ ->
  editMenu()
  $('#transit_menu_select select').trigger('change')
  $('#transit_menu_form_area').on 'reload', ()->
    editor = $('#transit_menu_items')
    new Menu( editor ) if editor.length isnt 0

  