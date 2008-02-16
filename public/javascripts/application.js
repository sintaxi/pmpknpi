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
     // if ($(event.target).is('a.remote_delete')) {
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
  
  
  
  //  // Add onclick handler to checkbox w/id checkme
  // $("#checkme").click(function(){ 
  //  // If checked
  //  if ($("#checkme").is(":checked")){
  //    //show the hidden div
  //    $("#extra").show("fast");
  //    }else{      
  //    //otherwise, hide it
  //    $("#extra").hide("fast");
  //  }
  // });


  
  //Hide div w/id extra
  // $("#extra").css("display","none");
  //  // Add onclick handler to checkbox w/id checkme
  // $("#checkme").click(function(){ 
  //  // If checked
  //  if ($("#checkme").is(":checked")){
  //    //show the hidden div
  //    $("#extra").show("fast");
  //    }else{      
  //    //otherwise, hide it
  //    $("#extra").hide("fast");
  //  }
  // });
     
});