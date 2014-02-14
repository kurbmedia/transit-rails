class @Transit.Interface extends Transit.Module
  @include Transit.Logger
  
  ##
  # Build the component and its container groups
  #
  constructor:( @el )->
    @Components = new InterfaceGroup( jQuery('#transit_toolbar') )
    @Plugins    = new InterfaceGroup( jQuery('#transit_plugin_bar') )
    @Actions    = new InterfaceGroup( jQuery('#transit_action_bar') )
  
  
  ##
  # Takes either an array of options, or an options hash
  # and builds a component/plugin etc.
  #
  build: (name, type, props = {})=>
    
    if jQuery.type( props ) is 'array' # Array notation: [ Type,  { option: 'value', option2: 'value' }]
      klass   = props[0]
      options = props[props.length - 1]
    else if jQuery.type( props ) is 'object'  # Object notation: { type: 'type', option: 'value' }]
      klass = props.type.toString()
      options = props
    else 
      @warn("Invalid options passed for #{type} '#{name}'. Skipping object.")
      return false
    
    type  = type.pluralize()
    base  = Transit[type]
    
    if base is undefined
      @error("Invalid object type: #{type}")
      return false

    klass = base[klass]
    if klass is undefined
      @error("Invalid object type: #{type}")
      return false

    new klass( name, options )
  
  
  ##
  # Re-render the various components from a passed configuration hash.
  # Returns an array of all created objects. 
  #
  render: (options = {})=>
    Transit.trigger('before:render', @)
    mod.empty() for mod in [@Components, @Plugins, @Actions]
    result = []

    Transit.trigger('render')
    for type, items of options
      klass = type.toString().camelize()
      unless @[klass]
        Transit.warn("Unknown component or resource type '#{type}/#{klass}'")
        continue
      
      for name, props of items
        item = @build( name, klass, props )
        continue unless item
        @log("Add item to #{klass}", props)
        @[klass].append( item )
        result.push( item )
    
    Transit.trigger('after:render')
    result


##
# Placeholder classes for element groups
#
class InterfaceGroup
  items: []
  constructor: (@el)->

  ##
  # Append a node to the group
  #
  append: (obj)=> 
    @items.push( obj )
    @el.append( obj.el )
    @count = @items.length
    Transit.trigger('ui:update', obj, @)
    @
  
  
  ##
  # Get an item from the group, either by index in 'items', or by name
  #
  get:(search)=>
    return @items[ search ] unless isNaN(search)
    for item in @items
      result = item if item.name is search
    result
  
  
  ## 
  # Empty the group, removing all sub-components 
  # unless they are flagged to be kept. 
  # Optionally allow forcing removal.
  #
  empty: ( force = false)=>
    item.destroy?(force) for item in @items
    @count = 0
    @items = []
    @
  
  
  ##
  # Prepend a node to the group
  #
  prepend: (obj)=> 
    @items.push( obj )
    @el.prepend( obj.el )
    @count = @items.length
    Transit.trigger('ui:update', obj, @)