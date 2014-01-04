class Transit.MediaLibrary
  
  constructor:( @modal = m )->
    @node = @modal.element
    


@Mercury.modalHandlers.mediaLibrary = ()-> 
  if @klass is undefined
    @klass = new Transit.MediaLibrary(@)