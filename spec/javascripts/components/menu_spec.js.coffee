#= require spec_helper

describe 'Transit.Components.Menu', ->
  
  comp = null
  spy  = null
  node = null
  menu = null
  
  buildMenu = (options = {})->
    comp ||= new Transit.Components.Menu('test', options)
    node = comp.el
    menu = comp.menu
  
  find = (sel)-> node.find(sel)
  afterEach -> comp = undefined
  
  
  describe 'any instance', ->
    
    beforeEach ->
      comp = buildMenu()

    
    it 'builds a link to toggle the menu', ->
      expect( find('a.dropdown-toggle') )
        .to.have.length(1)
    
    
    describe 'when passed items', ->
      
      beforeEach ->
        buildMenu( items: [
          { label: "Test" }
        ])
      

      it 'creates an empty menu list', ->
        expect( comp.menu )
          .to.exist
      
      
      it 'adds the items to the menu', ->
        expect( menu.find('> li') )
          .to.have.length 1
    
    
    describe 'when passed no items', ->
      
      beforeEach -> 
        buildMenu()
      
      
      it 'does not create the menu', ->
        expect( comp.menu )
          .to.not.exist
        

  describe 'the addItems method', ->
    
    beforeEach ->
      buildMenu(items: [
        { label: "Test" },
        { label: "Test2" }
      ])
    
    
    it 'adds items to the menu', ->
      expect( menu.find('> li') )
        .to.have.length 2
      
    
    describe 'when the menu already has items', ->
      
      itm = null
      
      beforeEach ->
        comp.addItems([
          { label: "Replace" }
        ])

        itm = comp.items[0]
      
      
      it 'removes all of the existing items', ->
        expect( menu.find('> li') )
          .to.have.length 1
      
      
      it 'calls .destroy on all of the existing items', ->
        spy = sinon.spy(itm, 'destroy')
        comp.addItems([])
        expect( spy.called )
          .to.eq true


  describe 'the addItem method', ->
    
    describe 'when the menu already has items', ->
      
      beforeEach ->
        buildMenu(items: [
          { label: "Test" },
          { label: "Test2" }
        ])
      
      
      it 'appends the new item to the existing items', ->
        comp.addItem({ label: "Add" })
        expect( menu.find('> li') )
          .to.have.length 3
        