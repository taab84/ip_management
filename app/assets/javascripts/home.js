$(function() {
  setTimeout(function(){
    $('.alert').slideUp(400);
  }, 1800);
});

$.fn.datepicker.defaults.daysOfWeekDisabled = "5,6";
$.fn.datepicker.defaults.daysOfWeekHighlighted = "5,6";
$.fn.datepicker.defaults.autoclose = true;
$.fn.datepicker.defaults.todayHighlight = true;

$.fn.datepicker.dates['fr'] = {
  days: ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"],
  daysShort: ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"],
  daysMin: ["Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa"],
  months: ["Janvier", "Favrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"],
  monthsShort: ["Jan", "Fev", "Mar", "Avr", "Mai", "Jun", "Jul", "Aou", "Sep", "Oct", "Nov", "Dec"],
  today: "Aujourd'hui",
  clear: "Effacer",
  format: "dd/mm/yyyy",
  titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
  weekStart: 0
};
