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
//= require jquery.jplayer.min
//= require jquery.masonry.min
//= require_tree .
//
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
    pause: function(e){
      $(this).jPlayer("clearMedia");
    },
    error: function(event) {
      if(ready && event.jPlayer.error.type === $.jPlayer.error.URL_NOT_SET) {
        // Setup the media stream again and play it.
        $(this).jPlayer("setMedia", stream).jPlayer("play");
      }else{
        console.log("jPlayer error!");
        if (typeof(_gaq) === "object") {
          _gaq.push([
            "_trackEvent",
            "jPlayer error!",
            event.jPlayer.error.type,
            "",
            0, true
            ]);
        }
      }
    },
    solution: "html, flash",
    cssSelectorAncestor: "#jp_container"
  });

  setInterval(function(){
    $.get("/metadata",function(data){
      console.log("got data: "+data);
      $(".jp-title").html(data);
      if(data.indexOf('LIVE') == 0) {
        $(".jp-title").addClass("crazy");
      } else {
        $(".jp-title").removeClass("crazy");
      }
    });
  },5000);
});

window.onerror = function(message, url, line) {
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
