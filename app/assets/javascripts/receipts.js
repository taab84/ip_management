$(document).on('turbolinks:load', function() {
  var selectizeCallback = null;

  var select_order = $(".selectize").selectize({
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
      load: function(query, callback) {
          select_order.selectize()[0].selectize.clearOptions();
      if (!query.length) return callback();
        $.ajax({
            url: '/orders/list',
            type: 'get',
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
              // console.log(res);
            }
        });
      },
      create: function(input, callback){
        selectizeCallback = callback;
        $(".order-modal").modal();
        $("#new_order").trigger("reset");
      }
  });

  $('#payement').on('cocoon:after-insert', function(e, insertedItem) {
         $('.datepicker').datepicker();
      });

  $("#new_order").on("submit", function(e){
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: '/orders/',
      data: $(this).serialize(),
      success: function(res){
        selectizeCallback(res);
        selectizeCallback = null;
        $(".order-modal").modal('toggle');
        $.rails.enableFormElement($("#new_order"));
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