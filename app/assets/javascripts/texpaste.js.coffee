window.tp =
  trackViews: (id) ->
    params = {id: id}
    $.post('/notes/update_views', params)