#= require spec_helper

describe 'Transit.Components.MenuItem', ->
  
  comp = null
  link = null
  spy  = null
  
  buildItem = (options = {})->
    comp = new Transit.Components.MenuItem('Test', options )
    link = comp.el.find('> a')
  
  
  describe 'components options', ->
    
    describe 'when they contain .url', ->
      
      beforeEach ->
        buildItem( url: 'http://google.com' )
      
      
      it 'assigns the url to the link', ->
        expect( link.attr('href') )
          .to.equal 'http://google.com'
      
      
      it 'sets the link target to the iframe', ->
        expect( link.attr('target') )
          .to.equal 'transit_iframe'
    
    
    describe 'when they contain a .label', ->
      
      beforeEach ->
        buildItem( label: 'Google' )
      
      
      it 'sets the link text to the label', ->
        expect( link.text() )
          .to.equal 'Google'
  
  
  describe 'when the item is clicked', ->
    

    describe 'when a url is present', ->
      
      spy = null
      
      beforeEach ->
        spy = sinon.spy()
        buildItem
          url: 'http://google.com'
          handler: spy
        comp.el.find('a')
          .click()
      
      
      it 'does not run the handler', ->
        expect( spy.called )
          .to.eq false
    

    describe 'when no url is present', ->
      
      spy = null
      
      beforeEach ->
        spy = sinon.spy()
        buildItem
          handler: spy
        comp.el.find('a')
          .click()
      
      
      it 'runs the handler', ->
        expect( spy.called )
          .to.eq true
        
        