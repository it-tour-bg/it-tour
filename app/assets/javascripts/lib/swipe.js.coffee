do($) ->
  swipeDirectionFor = (element) ->
    options = element.data 'swipe:options'
    x1      = element.data 'swipe:start:x1'
    x2      = element.data 'swipe:start:x2'
    y1      = element.data 'swipe:start:y1'
    y2      = element.data 'swipe:start:y2'

    return false unless x1? and x2? and y1? and y2?

    dx = x1 - x2
    dy = y1 - y2

    return if dx > 0 then 'left' else 'right' if Math.abs(dx) >= options.minX
    return if dy > 0 then 'down' else 'up'    if Math.abs(dy) >= options.minY

    false

  resetData = ->
    $(this)
      .removeData(['swipe:start:x1', 'swipe:start:x2', 'swipe:start:y1', 'swipe:start:y2'])
      .off('.swipeCheck')

  checkData = ->
    element   = $(this)
    direction = swipeDirectionFor(element)

    if direction
      element.trigger 'swipe'
      element.trigger "swipe:#{direction}"

    resetData.call(this)

  recordData = (jqEvent) ->
    e = jqEvent.originalEvent
    return unless e?.touches?.length == 1

    $(this)
      .data('swipe:start:x2', e.touches[0].pageX)
      .data('swipe:start:y2', e.touches[0].pageY)

  onTouchStart = (jqEvent) ->
    e = jqEvent.originalEvent
    return unless e?.touches?.length == 1

    $(this)
      .data('swipe:start:x1', e.touches[0].pageX)
      .data('swipe:start:y1', e.touches[0].pageY)
      .bind
        'touchmove.swipeCheck':    recordData
        'touchend.swipeCheck':     checkData
        'touchcancel.swipeCheck':  resetData

  $.fn.observeSwipe = (options = {}) ->
    return @ unless 'ontouchstart' of document.documentElement

    @data 'swipe:options', $.extend({minX: 30, minY: 30}, options)
    @on 'touchstart', onTouchStart

