window.App || (window.App = {});

App.init = function() {
  return $("a, span, i, div").tooltip();
};

$(document).on("turbolinks:load", function() {
  return App.init();
  $.rails.refreshCSRFTokens();
  var AUTH_TOKEN;
  var receipt_type;
});
