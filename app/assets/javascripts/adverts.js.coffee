# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('[data-controller=adverts]').ready ->
  $('#mp3-uploader').S3Uploader
    allow_multiple_files: false
    remove_completed_progress_bar: false
    done: (e, data) ->
      console.log("done!")

  $('#mp3-uploader').on 's3_uploads_start', (e) ->
    console.log("Uploads have started")
    $("#status").html("uploading...")

  $('#mp3-uploader').on "ajax:success", (e, data) ->
    console.log("server was notified of new file on S3; responded with "+data)
    $("#new_podcast").attr("action","/adverts/"+data.id)
    $("#status").html("complete!")

  $('#mp3-uploader').on "ajax:error", (e, data) ->
    console.log("there was an error; responded with "+data)
    $("#status").html("error! :(")
