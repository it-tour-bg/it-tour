do ($)->
  class ScrollSpy
    constructor: (element, options) ->
      options = $.extend({}, $.fn.scrollspy.defaults, options)

      @selector = options.selector
      @offset = options.offset

      @element = $(element)
      @element.on 'click', 'a[href*=#]', (e) =>
        [element, hash] = @findElementAndHash $(e.target)

        if element
          e.preventDefault()
          $.scrollTo element,
            duration: 300,
            onAfter: -> location.hash = hash

      @window = $(window)
      @window.on 'scroll', => @process()
      @window.on 'load resize', => @refresh()

      @refresh()

    refresh: ->
      @items = []
      @element
        .find(@selector)
          .map (_, link) =>
            [element, hash] = @findElementAndHash $(link)
            [offset: element.position().top, hash:hash] if element
          .sort((a, b) -> a[0] - b[0])
          .each (_, value) =>
            @items.push value if value

      @process()

    findElementAndHash: (href) ->
      match = href.attr('href').match(/#.*/)
      hash = match && match[0]
      return [] unless hash

      element = $(hash)
      if element.length > 0
        [element, hash]
      else
        []

    process: ->
      scrollTop = @window.scrollTop() + @offset
      maxScroll = document.body.scrollHeight - @window.height()

      if scrollTop >= maxScroll
        @activate @items[@items.length - 1]?.hash
        return

      for item, i in @items
        nextOffset = @items[i + 1]?.offset
        if scrollTop >= item.offset && (!nextOffset || scrollTop <= nextOffset)
          @activate item.hash
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


