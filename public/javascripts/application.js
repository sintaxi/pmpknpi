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
       if (confirm("Oops! Do you really mean to delete?")) {
         $('<form method="POST" style="display:none"></form>').attr('action', event.target.href ).html('<input type="hidden" name="_method" value="delete" />').appendTo("body")[0].submit();
         return false;
       }else{
         return false;
       }
     }
   
  });
  
  function SaveAsDraftCheck(){
    if($("#article_draft").is(":checked")){
      $("#publish_on").hide();
    }else{
      $("#publish_on").show();
    }
  }
  $("#article_draft").click(function(){
    $(document).ready(SaveAsDraftCheck);
  });
  $(document).ready(SaveAsDraftCheck);
  
  $("a.excerpt_toggle").click(function () {
    $("li.article_excerpt").toggle();
    return false;
  });
     
});