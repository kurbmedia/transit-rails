#= require spec_helper

describe 'Transit.Components.Button', ->
  
  comp = null
  spy  = null
  
  buildItem = (options = {})->
    comp = new Transit.Components.Button('Test', options)
  
  
  describe 'when the button is clicked', ->
    
    beforeEach ->
      spy = sinon.spy()
      buildItem
        handler: spy
      comp.el.click()
    
    
    it 'the handler function is called', ->
      expect( spy.called )
        .to.eq true