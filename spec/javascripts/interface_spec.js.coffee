#= require spec_helper

describe 'Transit.Interface', ->
  
  tBar       = null
  Components = null
  Plugins    = null
  item       = null
  items      = null
  
  describe 'the interface .el', ->
    
    loadFixture 'toolbar', (dat)->
      Transit.init()
      tBar = Transit.UI
    
    
    it 'is assigned on creation', ->
      expect(tBar.el)
        .to.exist
    
    
    it 'is assigned to the primary toolbar', ->
      expect(tBar.el.attr('id'))
        .to.equal('transit_primary_toolbar')
      
      
  describe 'rendering the interface', ->
    
    data = null
    
    loadFixture 'toolbar', (dat)->
      Transit.init()
    
    describe 'after rendering', ->
      
      beforeEach -> 
        Transit.render(MockInterface.array)
        tBar = Transit.UI
        Components = tBar.Components
      
      it 'adds the nodes to the interface', ->
        result = tBar.Components
          .el.find('li.dropdown') 
        expect( result )
          .to.have.length 1
    
    
    describe 'when passing array-style values', ->
      
      beforeEach -> 
        Transit.render(MockInterface.array)
        tBar = Transit.UI
        Components = tBar.Components


      it 'adds each item by name', ->
        expect( Components.get(0).name )
          .to.equal 'test'
      
      
      it 'assigns any options to the item', ->
        expect( Components.get(0)
          .options.label)
          .to.equal "Basic Menu"


      it 'adds items based on the type', ->
        expect( Components.count )
          .to.equal 1
      
      
    describe 'when passing object style values', ->
      
      beforeEach -> 
        Transit.render(MockInterface.object)
        tBar = Transit.UI
        Components = tBar.Components
        
      
      it 'adds each item by name', ->
        expect( Components.get(0).name )
          .to.equal 'test'
      
      
      it 'adds items based on the type', ->
        expect( Components.count )
          .to.equal 1
      
      
      