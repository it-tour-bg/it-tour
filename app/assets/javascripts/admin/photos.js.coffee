#= require vendor/plupload
#= require vendor/underscore
#= require vendor/backbone

$('#js-photos').each ->
  class PhotosView extends Backbone.View
    events:
      'click [data-action="delete"]': 'deletePhoto'

    initialize: ->
      @uploader = new plupload.Uploader
        browse_button: 'js-photo-upload'
        runtimes:      'html5'
        max_file_size: '20mb'
        url:           @$el.data('url')
        filters:       [{title: 'Photos:', extensions: 'jpg,jpeg,png'}]
      @uploader.init()
      @uploader.bind 'FilesAdded', (uploader, files) =>
        @addPlaceholder file for file in files
        uploader.start()
      @uploader.bind 'FileUploaded', (uploader, file, xhr) =>
        @addPhoto file, JSON.parse(xhr.response)
      @uploader.bind 'Error', ->
        alert 'File transfer failed'

      @$('script[type="text/json"]').each (i, el) =>
        script = $(el)
        photos = JSON.parse(script.html())
        @$('article').prepend @photoHtml(photo) for photo in photos
        script.remove()

    addPlaceholder: (file) ->
      @$('article').prepend """
        <div id="photo-#{file.id}"><mark></mark></div>
      """

    addPhoto: (file, data) ->
      @$("#photo-#{file.id}").replaceWith @photoHtml(data)

    photoHtml: (photo) ->
      """
        <div data-id="#{photo.id}">
          <img src="#{photo.asset_url}" />
          <button class="btn" data-action="delete">Delete</button>
        </div>
      """

    deletePhoto: (e) ->
      element = $(e.target).closest('div')
      $.ajax(@$el.data('url') + '/' + element.data('id'), {type: 'delete'})
      element.hide 'fast', -> element.remove()

  new PhotosView el: this
