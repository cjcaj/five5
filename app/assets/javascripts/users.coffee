# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.cloudinary-fileupload').on 'cloudinarydone', (e, data) ->
    $('#preview').html(
      $.cloudinary.image(data.result.public_id))
    $.ajax '',
      type: 'PUT'
      data:
        image_id: [data.result.resource_type, data.result.type, data.result.path].join("/") + "#" + data.result.signature
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Something went wrong"
