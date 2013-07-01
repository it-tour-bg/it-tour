#= require vendor/jquery.ui.sortable
#= require vendor/plupload
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/backbone_bind_to

$('#js-photos').each ->
  class Uploader
    constructor: (url) ->
      @uploader = new plupload.Uploader
        browse_button: 'js-photo-upload'
        runtimes:      'html5'
        max_file_size: '20mb'
        url:           url
        filters:       [{title: 'Photos:', extensions: 'jpg,jpeg,png'}]

      @uploader.init()

      @uploader.bind 'FilesAdded', (uploader, files) =>
        @trigger 'file:added', file.id for file in files
        uploader.start()

      @uploader.bind 'FileUploaded', (uploader, file, xhr) =>
        @trigger 'file:uploaded', file.id, JSON.parse(xhr.response)

      @uploader.bind 'Error', (uploader, response) =>
        @trigger 'file:error', response.file.id

        @$("#photo-#{response.file.id}").remove()
        alert 'File transfer failed'


  _.extend Uploader.prototype, Backbone.Events

  PhotoStore =
    baseUrl: $(this).data('url')

    ajax: (url, options = {}) ->
      $.ajax "#{@baseUrl}/#{url}", options

    reorder: (ids) ->
      @ajax 'reorder', type: 'patch', data: {ids: ids}

    remove: (id) ->
      @ajax id, type: 'delete'

    each: (callback) ->
      $('script[type="text/json"]').each (i, el) =>
        script = $(el)
        photos = JSON.parse(script.html())
        callback(photo) for photo in photos
        script.remove()

  class PhotosView extends Backbone.View
    events:
      'click [data-action="delete"]': 'deletePhoto'

    bindToModel:
      'file:added':    'photoWasAdded'
      'file:uploaded': 'photoWasUploaded'
      'file:error':    'photoWasntUploaded'

    photoWasAdded: (fileId) ->
      @$article.prepend """<div id="photo-#{fileId}"><mark></mark></div>"""

    photoWasUploaded: (fileId, data) ->
      @$("#photo-#{fileId}").replaceWith @photoHtml(data)

    photoWasntUploaded: (fileId) ->
      @$("#photo-#{fileId}").remove()
      alert 'File transfer failed'

    initialize: ->
      @$article = @$ 'article'

      @collection.each (photo) => @$article.append @photoHtml(photo)

      @$('article').sortable
        placeholder: "ui-state-highlight"
        update:      (e, ui) => @collection.reorder @$article.find('div').map(-> $(this).data('id')).toArray()

    photoHtml: (photo) ->
      """
        <div data-id="#{photo.id}">
          <img src="#{photo.asset_url}" />
          <button class="btn" data-action="delete">Delete</button>
        </div>
      """

    deletePhoto: (e) ->
      element = $(e.target).closest('div')
      @collection.remove element.data('id')
      element.hide 'fast', -> element.remove()


  uploader = new Uploader $(this).data('url')
  new PhotosView el: this, model: uploader, collection: PhotoStore
