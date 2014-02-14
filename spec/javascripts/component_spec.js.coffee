#= require spec_helper

describe 'Transit.Component', ->
  
  tBar = null  
  comp = null
  spy  = null
  
  loadFixture 'toolbar', (dat)-> 
    Transit.init()
    tBar = Transit.UI
  
  
  describe 'any instance', ->
    
    beforeEach ->
      comp = build(Transit.Component, "test")
      comp.css(color: 'blue')
      comp.addClass('pink')
    
    
    it 'delegates .css to the element', ->
      expect( comp.el.css('color') )
        .to.equal 'blue'
    
    
    it 'delegates .addClass to the element', ->
      expect( comp.el.hasClass('pink') )
        .to.eq true
    
    
    it 'delegates .removeClass to the element', ->
      comp.removeClass('pink')
      expect( comp.el.hasClass('pink') )
        .to.eq false
    
    
    it 'creates its .el from options.tag', ->
      expect( comp.el.is("li") )
        .to.eq true
    
    
  
  describe 'component options', ->
  
    describe 'when they contain .el', ->
    
      node = jQuery('<div class="stub"></div>')
      beforeEach ->
        comp = build(Transit.Component, "test", el: node)
    
      it 'assigns the element to the instance', ->
        expect(comp.el.get(0))
          .to.equal(node.get(0))
  
  
    describe 'when they contain .html', ->
    
      beforeEach ->
        comp = build(Transit.Component, 
          "test", 
          html: "<span></span>"
        )
      
      it 'renders the custom html into the component', ->
        expect( comp.el.html() )
          .to.equal("<span></span>")
  
    
    
    describe 'when they contain .attributes', ->
      
      beforeEach ->
        comp = buildComponent
          attributes: 
            id: 'some_id'


      it 'assigns the attributes to the element', ->
        expect( comp.el.attr('id') )
          .to.equal "some_id"
    
    
    describe 'when they contain .classes', ->
      
      beforeEach ->
        comp = buildComponent
          classes: "item"
      

      it 'assigns the classes to the element', ->
        expect( comp.el.hasClass('item') )
          .to.eq true
    
    
    describe 'when they contain .keep', ->
      
      beforeEach ->
        comp = buildComponent
          keep: true
      
      
      it 'sets the component to be kept on destroy', ->
        expect( comp.keep )
          .to.eq true
    
    
    describe 'when they contain .icon', ->
      
      beforeEach ->
        comp = buildComponent
          icon: "check"

      
      it 'builds an icon node', ->
        expect( comp.buildIcon() )
          .to.not.equal ''
      

  describe 'the destroy method', ->

    
    describe 'when .keep is set to true', ->
      
      beforeEach -> 
        comp = buildComponent(keep: true)
        spy  = sinon.spy(comp.el, 'remove')
        comp.destroy()

      
      it 'does not remove the element', ->
        expect( spy.called )
          .to.eq false
    
    
    describe 'when .keep is set to false', ->
      
      beforeEach -> 
        comp = buildComponent(keep: false)
        spy  = sinon.spy(comp.el, 'remove')
        comp.destroy()
        
      
      it 'removes the element', ->
        expect( spy.called )
          .to.eq true
      
        