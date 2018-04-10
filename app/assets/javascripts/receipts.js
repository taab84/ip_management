$(document).on('turbolinks:load', function() {
  var selectizeCallback = null;
  var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  var select_order = $("#receipt_orders").selectize({
      plugins: ['remove_button', 'drag_drop'],
      valueField: 'id',
      labelField: 'number',
      searchField: 'number',
      delimiter: ',',
      render: {
        option_create: function (data, escape) {
            return '<div class="create">' + I18n.t("javascript.add") + '&hellip;<strong>' + escape(data.input) + '</strong></div>';
        }
      },
      create: function(input, callback){
        selectizeCallback = callback;
        $("#new_order").trigger("reset");
        $(".order-modal").modal();
      },
      load: function(query, callback) {
          select_order.selectize()[0].selectize.clearOptions();
      if (!query.length) return callback();
        $.ajax({
            url: '/orders/list/',
            type: 'POST',
            dataType: 'json',
            data: {
                id: query,
                number: query,
                authenticity_token: AUTH_TOKEN,
              },
            error: function() {
              callback();
            },
            success: function(res) {
              callback(res);
            },
        });
      },
  });

  $('#payement').on('cocoon:after-insert', function(e, insertedItem) {
         $('.datepicker').datepicker();
      });

  $("#new_order").on("submit", function(e){
    e.preventDefault();
    $.ajax({
      method: "post",
      url: '/orders/',
      data: $(this).serialize(),
      dataType: 'json',
      success: function(res){
        selectizeCallback(res);
        selectizeCallback = null;
        select_order.selectize()[0].selectize.addOption(res);
        select_order.selectize()[0].selectize.setValue(res.id, false);
        $(".order-modal").modal('toggle');
        $("#new_order_submit").removeAttr("disabled");
      },
    });
  });

  $(".order-modal").on("hide.bs.modal", function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selecitzeCallback = null;
    }
  });

  select_order.selectize()[0].selectize.clearOptions();
});