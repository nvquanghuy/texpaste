$ ->
  $('#manual h5').click (e) ->
    panel = $(this).next()
    if panel.is(':visible')
      panel.slideUp(duration: 200)
    else
      panel.slideDown(duration: 200)

    return false

  # show the first box
  $('#manual ul').hide()
  $('#manual ul:first').show()


window.showNoteInit = ->
  text = $("#render_div").html()
  text = convertTextToMathJaxReady(text)
  $("#render_div").html(text)
  MathJax.Hub.queue.Push(["Typeset", MathJax.Hub, "render_div"])
