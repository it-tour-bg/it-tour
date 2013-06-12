#= require jquery
#= require 'vendor/jquery.countdown'
#= require 'vendor/jquery.scrollspy'
#= require 'vendor/jquery.scroll_to'
#= require_self

$('[data-counter]').each ->
  element = $(this)
  element.countdown until: new Date(element.data('counter'))

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


