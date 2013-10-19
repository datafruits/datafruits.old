//= require jquery

$(document).ready(function(){
  for(var i = 0; i < 200; i++){
    var el = $("<span id='scroller'>★</span>");
    $("#scroll-container").append(el);
    el.css('left',i*50);
  }
});
