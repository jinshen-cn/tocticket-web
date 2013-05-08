$(document).ready ->
  $('#event_celebrated_at').focusout ->
    $('#event_selling_deadline').val($('#event_celebrated_at').val()) if $('#event_selling_deadline').val().length is 0

$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('tr').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $("#fields table").append($(this).data('fields').replace(regexp, time))
  event.preventDefault()