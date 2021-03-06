$(document).on('turbolinks:load', function() {
  if (($("#receipt").length > 0)) {
    $(".wilaya").selectize({
      maxOptions: 5
    });
    $(".representative").selectize({
      maxOptions: 5
    });
  }

  if ((!($("#receipt").length > 0)) || ($(".receipts.edit").length > 0)) {
    return;
  }
  
  var selectizeCallback = null;
  var select_order = $("#receipt_orders").selectize({
      plugins: ['remove_button', 'drag_drop'],
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',
      delimiter: ',',
      render: {
        option_create: function (data, escape) {
            return '<div class="create">' + I18n.t("javascript.add") + '&hellip;<strong>' + escape(data.input) + '</strong></div>';
        },
        option: function(item, escape) {
          return '<div>'
            + '<strong>'       
            + escape(item.number) + ': ' 
            + '</strong>' 
            + escape(item.name) + ' (' 
            + escape(item.remain)  + ') '
            + '</div>';
        },
        item: function(item, escape){
          return '<div>'
            + '<strong>'       
            + escape(item.number) + ': ' 
            + '</strong>' 
            + escape(item.name) + ' (' 
            + escape(item.remain)  + ' Da) '
            + '</div>';
        }
      },
      create: function(input, callback){
        selectizeCallback = callback;
        $("#new_order").trigger("reset");
        $(".order-modal").modal();
      },
      load: function(query, callback) {
        select_order.selectize()[0].selectize.clearOptions();
        AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
        if (!query.length) return callback();
          $.ajax({
              url: '/orders/load/',
              type: 'POST',
              dataType: 'json',
              data: {
                  query: query,
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
        select_order.selectize()[0].selectize.addItem(res.id, false);
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