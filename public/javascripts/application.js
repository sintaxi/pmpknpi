$(document).ready(function() {

  // toggle admin panel
  $("a.toggle_panel").click(function(){
     $("div.admin").toggle();
     return false;
   });
  
  
  // Listener
  $('body').click(function(event) {
   
     // remote link
     if ($(event.target).is('a.remote')) {
       $.ajax({
         url: event.target.href,
         beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");},
         success: function(data){
           eval(data);
           }
       });
       return false;
     }
   
  });
  
  // ajax form (jquery.form.js)
  $("form.remote").ajaxForm({
    dataType: 'script',
    beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");},
    resetForm: true
  });
   
});