$(document).on('turbolinks:load', function() {
  var instance = $(".mark_receipt_orders").selectize({
      plugins: ['remove_button'],
      valueField: 'id',
      labelField: 'number',
      searchField: 'number',
      delimiter: ',',
      // highlight: false,
      loadThrottle: 1000,
      // openOnFocus: false,
      load: function(query, callback) {
          instance.selectize()[0].selectize.clearOptions();
      if (!query.length) return callback();
        $.ajax({
            url: 'http://localhost:3000/orders/select_request',
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
      }
  });


  document.getElementById("mark_receipt_payement_type").onchange = function() {Updatelocal()};
  document.getElementById("link_to_add_nested_check").style.display = 'none';

});

function Updatelocal() {
  var req = $("#mark_receipt_payement_type")[0].selectedIndex;
  if (req == 0) {
    document.getElementById("link_to_add_nested_transfer").style.display = 'inline-block';
    document.getElementById("link_to_add_nested_check").style.display = 'none';
  } else if (req == 1) {
    document.getElementById("link_to_add_nested_transfer").style.display = 'none';
    document.getElementById("link_to_add_nested_check").style.display = 'inline-block';
  }
}
