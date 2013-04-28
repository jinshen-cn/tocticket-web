$ ->
  $(document).on 'click', '#prices .new-ticket-type', (e) ->
    target = "#type-form"
    $(target).load($(this).data("url"), null, (response,status,xhr) ->
      if status == 'error'
        $(target).html('<div align="center">An error has occurred!</div>')
    )