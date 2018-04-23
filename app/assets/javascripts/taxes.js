$(document).on('turbolinks:load', function() {
  if (!($(".receipts.new").length > 0)) {
    return;
  }
  $('#receipt').change(function(){
      receipt_type = $('#receipt_type').val();
      AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
      var data = $(this).serializeArray();
      data.push({name: "type", value: receipt_type},{name: "authenticity_token", value: AUTH_TOKEN});
      $.ajax({
          method: "post",
          url: '/receipts/tax_evaluation',
          data: $.param(data) ,
          dataType: 'json',
          success: function(res){
              $('#total-value').html(res.total);
          },
          error: function(res){
            $('#total-value').html('error');
        },
      });  
  });
});