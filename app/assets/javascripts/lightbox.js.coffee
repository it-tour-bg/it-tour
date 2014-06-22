#= require vendor/underscore
#= require vendor/backbone
#= require vendor/backbone_bind_to

window.Lightbox = (container = $('body')) ->
  container.on 'click', '[data-src]', (e) ->
    target = $(e.target).closest('[data-src]')[0]

    index = 0
    elements = container.find('[data-src]').map (i, el) =>
      index = i if el == target
      new LB.Image($(el).data('src'))

    model = new LB.Items(items: elements.toArray(), index: index)
    view  = new LB.View(model: model)

    container.append view.el

    view.render()

LB = {}

class LB.Image
  constructor: (@src) ->
    @isLoaded = false
    @width    = 0
    @height   = 0

  # todo: promise
  load: (callback) ->
    return callback this if @isLoaded

    @image = new window.Image
    @image.onload = =>
      @isLoaded = true
      @width    = @image.width
      @height   = @image.height

      delete @image
      callback this

    @image.src = @src

class LB.Items extends Backbone.Model
  defaults:
    'index': 0
    'items':    []

  index: (value) ->
    if value == undefined
      @get 'index'
    else
      @set 'index', value

  item: (index = @get('index'))->
    @get('items')[index]

  count: ->
    @get('items').length

  previous: ->
    index = @get('index') - 1;
    @index if index >= 0 then index else @count() - 1

  next: ->
    index = @get('index') + 1;
    @index if index <= @count() - 1 then index else 0


class LB.View extends Backbone.View
  tagName: 'div'
  className: 'lightbox'

  template: """
    <button class="lb-close"></button>
    <div class="lb-container"></div>
    <div class="lb-controls">
      <button class="lb-previous"></button>
      <button class="lb-next"></button>
    </div>
  """
  events:
    'click .lb-close':     'close'
    'click .lb-next':      'next'
    'click .lb-previous':  'previous'

  bindToModel:
    'change:index': 'renderImage'

  initialize: ->
    @bindTo window, 'keyup', 'keyUp'

  keyUp: (e) ->
    switch(e.keyCode)
      when 27 then @close()
      when 37 then @previous()
      when 39 then @next()

  close: ->
    @$el.parent().removeClass 'lightbox-parent'
    @remove()

  render: ->
    @$el.parent().addClass 'lightbox-parent'
    @$el.html @template
    @renderImage()
    @

  next: ->
    @model.next()

  previous: ->
    @model.previous()

  renderImage: ->
    container = @$el.find '.lb-container'
    container.addClass 'lb-loading'
    container.html ''
    @model.item().load (image) =>
      container.removeClass 'lb-loading'
      container.html $('<img />').prop('src', image.src)
