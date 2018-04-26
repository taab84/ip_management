  $('.js-datepicker').datepicker();
  $('#overlayTrigger').click(function(event) {
    event.preventDefault();
    $('body').chardinJs('start');
  });

  $('.modal').on('shown.bs.modal', function() {
    $(this).find('[autofocus]').focus();
  });