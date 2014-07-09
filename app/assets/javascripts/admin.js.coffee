#= require jquery
#= require jquery_ujs
#= require bootstrap-alert
#= require_tree ./admin

$(document).on 'focus', 'textarea', ->
    namespace = 'sizer'
    textarea  = $(this)
    padding   = parseInt(textarea.css('paddingTop'), 10) + parseInt(textarea.css('paddingLeft'), 10)

    textarea.height textarea.prop('scrollHeight') - padding

    textarea.on "keypress.#{namespace} input.#{namespace} beforepaste.#{namespace}", ->
      textarea.height textarea.prop('scrollHeight') - padding

    textarea.on "blur.#{namespace}", ->
      textarea.height 1
      textarea.height textarea.prop('scrollHeight') - padding
      textarea.off ".#{namespace}"


$(document).on 'mousedown', 'select[multiple] option', ->
  $(this).data('selected', $(this).prop('selected'));

$(document).on 'mouseup', 'select[multiple] option', ->
  $(this).prop('selected', !$(this).data('selected'));

