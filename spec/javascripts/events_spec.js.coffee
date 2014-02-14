#= require spec_helper

describe 'Transit.Events', ->
  
  watch = null
  
  beforeEach ()->
    watch = sinon.spy()
    Transit.on('test', watch)
  
  describe '.on', ->
  
    it 'binds a global event', ->
      Transit.trigger('test')
      expect(watch.callCount)
        .to.equal 1
  
  
  describe '.off', ->
    
    it 'removes a global event handler', ->
      Transit.off('test', watch)
      Transit.trigger('test')
      expect(watch.called)
        .to.eq false
  
  
  describe '.one', ->
    
    beforeEach ->
      watch = sinon.spy()
      Transit.one('once', watch)
    
    it 'binds a global event to be executed once', ->
      Transit.trigger('once')
      Transit.trigger('once')
      expect(watch.calledOnce)
        .to.eq true
  

  describe '.trigger', ->
    
    it 'triggers a global transit event', ->
      Transit.trigger('test')
      expect(watch.called)
        .to.eq true
    
    
    it 'passes any arguments to the event handler', ->
      Transit.trigger('test', "prop")
      expect(watch.args[0][1])
        .to.equal 'prop'
