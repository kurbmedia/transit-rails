#= require ./menu_item

class @Transit.Components.Menu extends @Transit.Component
  options:
    label: "Menu"

  items: []
  
  
  ##
  # Rebuilds the menu by adding items from an array.
  #
  addItems:( items )=>
    # Remove any existing items
    item.destroy?() for item in @items
    
    @items = []
    @menu.empty()
    
    @addItem(item) for item in items
    @
      
  
  ##
  # Add a single item to the toolbar.
  #
  addItem:( item, method = 'append')=>
    adds = unless item is "|"
      itmName = item.label || "Item#{@items.length}"
      mitem   = new Transit.Components.MenuItem(itmName, item)
      @items.push( mitem )
      mitem.el
    else if item is '|'
      "<li class='divider'></li>"
    
    jQuery.fn[method].call(@menu, adds)
    @
    
  
  ##
  # Build the menu
  #
  build:() =>
    @options.html = "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>#{@options.label} <i class='fa fa-chevron-down'></i></a>"
    super
    @el.addClass('dropdown')
    return @el unless @options.items
    @menu = @el.find("> ul.dropdown-menu")
    unless @menu.length
      @el.append("<ul class='dropdown-menu'></ul>")
      @menu = @el.find("> ul.dropdown-menu")

    @addItems( @options.items )
    @el
    