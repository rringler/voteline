//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  var newValue = $("input#range-field").val();
  $("span#range-value").html(newValue);

  $("input#range-field").change(function() {
    var newValue = $("input#range-field").val();
    $("span#range-value").html(newValue);
  });
});
