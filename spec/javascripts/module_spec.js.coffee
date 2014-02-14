#= require spec_helper

describe 'Transit.Module', ->
  
  class ModuleSpec extends Transit.Module
  
  describe '#extend', ->
    
    beforeEach ->
      ModuleSpec
        .extend(MockObject)
    
    it 'adds class-level functions', ->
      expect(ModuleSpec.func)
        .to.be.a('function')
    
    it 'adds class-level properties', ->
      expect(ModuleSpec.prop)
        .to.equal true
  
  
  describe '#include', ->
    
    obj = null
    
    beforeEach ->
      ModuleSpec
        .include(MockObject)
      obj = new ModuleSpec()
    
    it 'adds instance-level functions', ->
      expect(obj.func)
        .to.be.a('function')
    
    it 'adds instance-level properties', ->
      expect(obj.prop)
        .to.equal true

      