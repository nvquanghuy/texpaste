$ ->
  $('#manual h4').click (e) ->
    panel = $(this).next()
    if panel.is(':visible')
      panel.slideUp(duration: 200)
    else
      panel.slideDown(duration: 200)

    return false

  # show the first box
  $('#manual ul').hide()
  $('#manual ul:first').show()