#= require spec_helper

describe 'Transit', ()->
  
  it 'is exposed as a global object', ->
    expect(window.Transit)
      .to_exist
  
  
  describe 'init', ->
  
    beforeEach -> Transit.init(conf: true, debug: true)

    
    it 'creates a UI instance', ->
      expect(Transit.UI)
        .to.exist
    
    
    it 'applies the passed configuration', ->
      expect(Transit.config.conf)
        .to.equal true
    
    
    it 'merges the config with the defaults', ->
      expect(Transit.config.debug)
        .to.equal(true)