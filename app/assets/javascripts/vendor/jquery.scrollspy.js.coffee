do ($)->
  class ScrollSpy
    constructor: (element, options) ->
      options = $.extend({}, $.fn.scrollspy.defaults, options)

      @selector = options.selector
      @offset = options.offset
      @element = $(element)
      @observer = if @element.is('body') then $(window) else @element
      @observer.on 'scroll.scrollspy', => @process()
      @observer.on 'load resize', => @refresh()
      @refresh()

    refresh: ->
      @offsets = []
      @targets = []
      @element
        .find(@selector)
        .map ->
          match = $(this).attr('href').match(/#.*/)
          hash = match && match[0]
          return null unless hash

          element = /^#.*/.test(hash) && $(hash)
          (element && element.length && [[element.position().top, hash]]) || null
        .sort((a, b) -> a[0] - b[0])
        .each (_, value) =>
          @offsets.push value[0]
          @targets.push value[1]

      @process()

    process: ->
      scrollTop = @observer.scrollTop() + @offset
      maxScroll = (@observer[0].scrollHeight || document.body.scrollHeight) - @observer.height()

      if scrollTop >= maxScroll
        @activate @targets[@targets.length - 1]
      else
        for offset, i in @offsets
          nextOffset = @offsets[i+1]
          if scrollTop >= offset && (!nextOffset || scrollTop <= nextOffset)
            @activate @targets[i]
            break

    activate: (target) ->
      return if target is @activeTarget
      @activeTarget = target
      @activeElements.removeClass('active') if @activeElements
      @activeElements = @element.find(@selector + '[href*="' + target + '"]')
        .addClass('active')
        .trigger('activate')

  $.fn.scrollspy = (option) ->
    @each ->
      element = $(this)
      data = element.data('scrollspy')
      element.data 'scrollspy', (data = new ScrollSpy(this,  typeof option is 'object' && option)) unless data
      data[option]() if typeof option is 'string'

  $.fn.scrollspy.defaults =
    offset: 10
    selector: 'nav a'


