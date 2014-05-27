#= require jquery
#= require 'vendor/jquery.plugin'
#= require 'vendor/jquery.countdown'
#= require 'vendor/jquery.scroll_to'
#= require 'vendor/jquery.scrollspy'
#= require_self

$.fn.eachWithElement = (callback) -> @each (i) -> callback $(this), i

$('[data-countdown]').eachWithElement (element) ->
  date = new Date(element.data('countdown'))
  element.countdown until: date, padZeroes: true

$('body').scrollspy(selector: '> nav a')

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
    .on 'scroll', -> nav.toggleClass 'sticky', $(document).scrollTop() > headerHeight
    .trigger 'scroll'
