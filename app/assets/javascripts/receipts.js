$(document).on('turbolinks:load', function() {
  var selectizeCallback = null;
  $('.datepicker').datepicker();

  var select_order = $(".receipt_orders").selectize({
      plugins: ['remove_button', 'drag_drop'],
      valueField: 'id',
      labelField: 'number',
      searchField: 'number',
      delimiter: ',',
      load: function(query, callback) {
          select_order.selectize()[0].selectize.clearOptions();
      if (!query.length) return callback();
        $.ajax({
            url: '/orders/select_request',
            type: 'POST',
            dataType: 'json',
            data: {
                id: query,
                number: query,
              },
              error: function() {
                callback();
            },
            success: function(res) {
              callback(res);
            }
        });
      },
      create: function(input, callback){
        selectizeCallback = callback;
        $(".order-modal").modal();
      }
  });

  $('#payement').on('cocoon:after-insert', function(e, insertedItem) {
         $('.datepicker').datepicker();
      });

  $("#new_payement_order").on("submit", function(e){
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: '/payement_orders/',
      data: $(this).serialize(),
      success: function(res){
        selectizeCallback(res);
        selectizeCallback = null;
        $(".order-modal").modal('toggle');
      }
    });
  });

  $(".order-modal").on("hide.bs.modal", function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selecitzeCallback = null;
    }
  });

});
