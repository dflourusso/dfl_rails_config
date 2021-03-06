// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.pt-BR.js
//= require bootstrap-filestyle
//= require_tree .
//require jquery.mask.min
//require jquery.mask.definitions

$(document).on("ready page:load", function() {
  $(".alert-dismissable" ).slideDown('fast').delay(3000).slideToggle('fast');
  initializeMasks();
  $('.datepicker').datepicker({
    language: "pt-BR",
    todayBtn: "linked",
    autoclose: true,
    todayHighlight: true,
    format: "dd/mm/yyyy"
  });
  $(":file").filestyle({
    buttonText: 'Selecionar arquivo',
    iconName: 'fa fa-folder-open',
    buttonName: 'btn-primary',
    buttonBefore: true,
    badge: true
  });
});
