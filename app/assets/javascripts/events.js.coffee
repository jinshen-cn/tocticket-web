$(document).ready ->
  $('#event_celebrated_at').focusout ->
    $('#event_selling_deadline').val($('#event_celebrated_at').val()) if $('#event_selling_deadline').val().length is 0

