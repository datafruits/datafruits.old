# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('[data-controller=podcasts]').ready ->
  $('#mp3-uploader').S3Uploader
    allow_multiple_files: false
    remove_completed_progress_bar: false
    additional_data:
      "podcast[pub_date(1i)]":  $("#podcast_pub_date_1i").val(),
      "podcast[pub_date(2i)]":  $("#podcast_pub_date_2i").val(),
      "podcast[pub_date(3i)]":  $("#podcast_pub_date_3i").val()
    done: (e, data) ->
      console.log("done!")

  $('#mp3-uploader').on 's3_uploads_start', (e) ->
    console.log("Uploads have started")
    $("#status").html("uploading...")

  $('#mp3-uploader').on "ajax:success", (e, data) ->
    console.log("server was notified of new file on S3; responded with "+data)
    $("#new_podcast").attr("action","/podcasts/"+data.id)
    $("#status").html("complete!")

  $('#mp3-uploader').on  "ajax:error", (e, data) ->
    $("#status").html("error! :(")
    console.log("there was an error; responded with "+data)
