$(document).ready(function() {
  
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
     
     //RESTful delete
     if ($(event.target).is('a.delete')) {
       $('<form method="POST" style="display:none"></form>').attr('action', event.target.href ).html('<input type="hidden" name="_method" value="delete" />').appendTo("body")[0].submit();
       return false;
     }
     
     
     // // remote delete
     // if ($(event.target).is('a.delete')) {
     //   $.ajax({
     //     type: "POST",
     //     data: {_method: "delete"},
     //     url: event.target.href,
     //     beforeSend: function(xhr) {
     //       confirm('are you sure?');
     //       xhr.setRequestHeader("Accept", "text/javascript");
     //       },
     //     success: function(data){
     //       eval(data);
     //       }
     //   });
     //   return false;
     // }
   
  });
  
  // ajax form (jquery.form.js)
  // $("form.remote").ajaxForm({
  //   dataType: 'script',
  //   beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");},
  //   resetForm: true
  // });
   
});