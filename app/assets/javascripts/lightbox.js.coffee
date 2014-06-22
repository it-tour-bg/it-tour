#= require vendor/underscore
#= require vendor/backbone
#= require vendor/backbone_bind_to

window.Lightbox =
  start: (container = $('body')) ->
    container.on 'click', '[data-src]', (e) ->
      target = $(e.target).closest('[data-src]')[0]

      index = 0
      elements = container.find('[data-src]').map (i, el) =>
        index = i if el == target
        new Lightbox.Image($(el).data('src'))

      model = new Lightbox.Items(items: elements.toArray(), index: index)
      view  = new Lightbox.View(model: model)

      container.append view.el

      view.render()

class Lightbox.Image
  constructor: (@src) ->
    @isLoaded = false
    @width    = 0
    @height   = 0

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

class Lightbox.Items extends Backbone.Model
  defaults:
    'index': 0
    'items': []

  index: (value) ->
    if value == undefined
      @get 'index'
    else
      @set 'index', value

  item: (index = @index()) ->
    @get('items')[index]

  count: ->
    @get('items').length

  previous: ->
    index = @get('index') - 1;
    @index if index >= 0 then index else @count() - 1

  next: ->
    index = @get('index') + 1;
    @index if index <= @count() - 1 then index else 0

class Lightbox.View extends Backbone.View
  tagName: 'div'
  className: 'lightbox'

  template: """
    <button class="lb-close"></button>
    <div class="lb-container">
      <img width="50%" height="50%" />
    </div>
    <div class="lb-cloak"></div>
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
    @$container = @$el.find '.lb-container'
    @cloak = new Lightbox.Cloak @$el.find('.lb-cloak')
    @renderImage()
    @

  next: ->
    @model.next()

  previous: ->
    @model.previous()

  renderImage: ->
    @cloak.cover @$container.find('img');

    @model.item().load (image) =>
      image = $('<img />').prop('src', image.src)
      image.appendTo(@$container)
      image.css marginTop: (@$container.height() - image.height())/2

      @cloak.uncover image

class Lightbox.Cloak
  constructor: (@el)->

  cover: (item) ->
    @el
      .fadeIn()
      .css(@clone(item))

    item.remove()

  uncover: (item) ->
    @el.animate @clone(item), =>
      @el.fadeOut()
      item.fadeIn()

    item.hide()

  clone: (el) ->
    top:     el.offset().top,
    left:    el.offset().left,
    width:   el.width(),
    height:  el.height()

