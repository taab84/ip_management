$(document).on('turbolinks:load', function() {
    var receipt_type = $('#receipt_type').val();
$('#receipt').change(function(){
    var data = $(this).serializeArray();
    data.push({name: "type", value: receipt_type});
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