// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery-ui
//= require cocoon
//= require Chart.min
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap-multiselect
//= require_tree .

$(document).ready(function() {
  $("body").on("click","#toggle_menu",function() {
    $(".main-menu,#toggle_menu").toggleClass("active")
    return false;
  });

  $("body").on("click",".open-modal",function(event) {
    event.preventDefault();
    $(".modal-overlay").show();
  });

  $("body").on("click",".close-modal",function(event) {
    event.preventDefault();
    $("#modal_data").empty();
    $(".modal-overlay").hide();
  });
});