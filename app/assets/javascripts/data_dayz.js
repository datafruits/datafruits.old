//= require jquery
//

$(document).ready(function(){
  var muted = false;
  $('#mute').click(function(){
    muted = !muted;
    if(muted == true){
      $(this).css("text-decoration","line-through");
      document.getElementById('negi_trap').muted = true;
    } else {
      $(this).css("text-decoration","none");
      document.getElementById('negi_trap').muted = false;
    }
  });
});
