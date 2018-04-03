$(document).on('turbolinks:load', function() {
    I18n.locale = $('body').data('locale');
    $.fn.datepicker.defaults.language = I18n.locale;
    return I18n.locale
  });