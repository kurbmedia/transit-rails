#= require jquery
#= require jquery_ujs
#= require transit
#= require sinon

#= require_tree ./fixtures

@expect  = chai.expect

@MockObject =
  func: ->
  prop: true


@MockInterface = 
  array:
    components:
      test: [ 'Menu', { label: "Basic Menu", items: [ { label: "Link 1" } ] }]
  object:
    components:
      test: [ 'Button', { label: "Button", handler: (->) }]
        

@build = (klass, args...)-> new klass(args...)
@buildComponent = (options = {})->
  new Transit.Component('Name', options)

  
addFixture = (data)->
  if jQuery('#fixtures').length is 0
    jQuery('<div id="fixtures"></div>')
      .appendTo('body')

  jQuery('#fixtures').html(data)

@loadFixture = (name, cb = null)->
  beforeEach (done)->
    data = JST["fixtures/#{name}"]
    addFixture(data)
    cb?(data)
    done()