#= require jquery
#= require 'vendor/jquery.countdown'
#= require 'vendor/jquery.scrollspy'
#= require 'vendor/jquery.scroll_to'
#= require_self

$.fn.eachWithElement = (callback) -> @each (i) -> callback $(this), i

$('[data-counter]').eachWithElement (element) ->
  element.countdown until: new Date(element.data('counter'))

$('[data-header-top]').eachWithElement (element) ->
  top = element.data('header-top')
  win = $(window)
  win.scroll -> element.toggleClass 'visible', win.scrollTop() > top

$('body')
  .scrollspy(selector: '> header a')
  .on 'click', 'a[href*=#]', (e) ->
    hash  = $(e.target).closest('a').attr('href')
    target = $(hash)

    if target.length > 0
      e.preventDefault()
      $.scrollTo target,
        duration: 300,
        onAfter: ->
          location.hash = hash


