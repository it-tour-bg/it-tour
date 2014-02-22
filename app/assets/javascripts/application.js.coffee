#= require jquery
#= require 'vendor/jquery.countdown'
#= require 'vendor/jquery.scroll_to'
#= require 'vendor/jquery.scrollspy'
#= require_self

$.fn.eachWithElement = (callback) -> @each (i) -> callback $(this), i

$('[data-countdown]').eachWithElement (element) ->
  date = new Date(element.data('countdown'))
  element.countdown until: date

$('body')
  .scrollspy(selector: '> nav a')
  .on 'click', 'a[href*=#]', (e) ->
    e.preventDefault()

    match = $(e.target).closest('a').attr('href').match(/#.*/)
    hash = match && match[0]
    return unless hash

    target = $(hash)
    if target.length > 0
      e.preventDefault()
      $.scrollTo target,
        duration: 300,
        onAfter: ->
          location.hash = hash

$("#streaming section iframe").eachWithElement (element) ->
  element.data('aspectRatio', element.height() / element.width())
  element.removeAttr 'height'
  element.removeAttr 'width'

$(window).resize ->
  $("#streaming section iframe").eachWithElement (element) ->
    newWidth = $("#streaming").width()
    newHeight = newWidth * element.data('aspectRatio')
    element.width newWidth
    element.height newHeight
.resize()

$ ->
  headerHeight = 10 + ($('header').height() || 0)
  body = $('body')
  nav = body.find('nav')
  $(window)
    .on 'scroll', -> nav.toggleClass 'sticky', body.scrollTop() > headerHeight
    .trigger 'scroll'
