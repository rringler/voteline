//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  var newValue = $("input#range-field").val();
  $("span#range-value").html(newValue);

  $("input#range-field").change(function() {
    var newValue = $("input#range-field").val();
    $("span#range-value").html(newValue);
    $("form.new_vote").submit();
    $("span#voted").html("true");
  });

  window.setInterval(function() { checkForResubmit() }, 5000);
});

function checkForResubmit() {
  if ($("span#voted").html() == "true") {
    $("form.new_vote").submit();
  }
}
