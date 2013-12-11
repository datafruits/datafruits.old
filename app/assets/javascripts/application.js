// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require modernizr-2.0.6
//= require jquery.jplayer
//= require jquery.masonry.min
//= require detect_timezone
//= require jquery.detect_timezone
//= require jquery.cookie
//= require rainbow
//= require s3_direct_upload
//= require_tree .
//
function small_top(){
  $("nav").addClass("sticky");
  $(".big-player").hide();
  $("#jp_container.mini-player").show();
}

function big_top(){
  $("nav").removeClass("sticky");
  $(".big-player").show();
  $("#jp_container.mini-player").hide();
}

$(document).ready(function(){
  var $container = $("#posts");
  $container.imagesLoaded(function(){
    $container.masonry({
      //options
      itemSelector: ".post",
      columnWidth: 300,
      isResizable: true,
      isAnimated: !Modernizr.csstransitions
    });
  });

  var stream = {
    mp3: "http://radio.datafruits.fm:8000/datafruits.mp3",
    oga: "http://radio.datafruits.fm:8000/datafruits.ogg"
  };
  var ready = false;

  $("#radio-player").jPlayer({
    ready: function () {
      ready = true;
      $(this).jPlayer("setMedia", stream);
    },
    swfPath: "/assets",
    supplied: "mp3, oga",
    wmode: "window",
    loadeddata: function(e){
      if(($(this).data('jPlayer').status.media.mp3 == stream.mp3) ||
         ($(this).data('jPlayer').status.media.oga == stream.oga)){
        $(".jp-title").html("playing...");
      }
    },
    playing: function(e) {
      $(".jp-loading").hide();
    },
    pause: function(e){
      $(this).jPlayer("clearMedia");
      $(this).jPlayer("setMedia", stream);
    },
    error: function(event) {
      console.log("jPlayer error: "+ event.jPlayer.error.type);
      $(this).jPlayer("setMedia", stream).jPlayer("play");

      $("jp-pause").hide();
      $("jp-loading").hide();
    },
    waiting: function(e) {
      $(".jp-loading").show();
      $(".jp-play").hide();
      $(".jp-pause").hide();
    },
    loadeddata: function(e) {
      $(".jp-loading").hide();
    },
    solution: "html, flash",
    cssSelectorAncestor: "#jp_container"
  });

  setInterval(function(){
    $.get("/metadata",function(data){
      $(".jp-title").html(data.currentsong);
      if(data.currentsong.indexOf('LIVE') == 0) {
        $(".jp-title").addClass("crazy");
      } else {
        $(".jp-title").removeClass("crazy");
      }
    });
  },5000);


  $("#user-menu").click(
    function(){
      $(this).addClass('open');
    },
    function(){
      $(this).removeClass('open');
    }
  );

  $(window).onerror = function(message, url, line) {
    //http://jsfiddle.net/phms/GAyrK/
    if (typeof(_gaq) === "object") {
      _gaq.push([
        "_trackEvent",
        "JS Exception Error",
        message,
        (url + " (" + line + ")"),
        0, true
        ]);
    }

   return true;
  };

  // grab the initial top offset of the navigation
  var sticky_navigation_offset_top = $('nav').offset().top;

  var sticky_navigation = function(){
    var scroll_top = $(window).scrollTop();

    if (scroll_top > sticky_navigation_offset_top) {
      small_top();
    } else {
      big_top();
    }
  };

  // run on load
  sticky_navigation();

  // and on every scroll
  $(window).scroll(function(){
    sticky_navigation();
  });

  window.BrowserTZone = {};
  BrowserTZone.setCookie = function(){
    $.cookie("browser.timezone", $().get_timezone(), { expires: 365, path: '/' });
  }
  BrowserTZone.setCookie();

  $('.rainbow').rainbow({animate:true,animateInterval:50,pauseLength:500,pad:true,colors:['rgb(153, 204, 255);','rgb(173, 224, 255);','rgb(193, 244, 255);','rgb(213, 264, 255);','rgb(193, 244, 255);','rgb(173, 224, 255);','rgb(153, 204, 255);']});

  $('#mp3-uploader').S3Uploader({
    allow_multiple_files: false,
    remove_completed_progress_bar: false,
    additional_data: {"podcast[pub_date(1i)]":  $("#podcast_pub_date_1i").val(),
                      "podcast[pub_date(2i)]":  $("#podcast_pub_date_2i").val(),
                      "podcast[pub_date(3i)]":  $("#podcast_pub_date_3i").val()
    },
    done: function(e, data){
      console.log("done!");
    }
  });

  $('#mp3-uploader').on('s3_uploads_start', function(e){
    console.log("Uploads have started");
  });

  $('#mp3-uploader').on( "ajax:success", function(e, data){
    console.log("server was notified of new file on S3; responded with "+data);
    $("#new_podcast").attr("action","/podcasts/"+data.id);
  });

  $('#mp3-uploader').on( "ajax:error", function(e, data){
    console.log("there was an error; responded with "+data);
  });

});
