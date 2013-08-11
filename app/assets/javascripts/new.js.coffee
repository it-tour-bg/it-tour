#= require jquery
#= require 'vendor/jquery.countdown'
#= require 'vendor/jquery.scroll_to'
#= require 'vendor/jquery.scrollspy'
#= require_self

$.fn.eachWithElement = (callback) -> @each (i) -> callback $(this), i

$('[data-countdown]').eachWithElement (element) ->
  date = new Date(element.data('countdown') * 1000)
  element.countdown until: date

$('body')
  .scrollspy(selector: '> header .sub a')
  .on 'click', 'a[href*=#]', (e) ->
    hash  = $(e.target).closest('a').attr('href')
    target = $(hash)

    if target.length > 0
      e.preventDefault()
      $.scrollTo target,
        duration: 300,
        onAfter: ->
          location.hash = hash

$(window).on 'scroll', -> $('header').toggleClass 'hide-nav', $('body').scrollTop() > 50
$(window).trigger 'scroll'
