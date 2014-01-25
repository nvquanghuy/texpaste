app.controller 'NoteEditorCtrl', ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->
  $scope.groups = []
  $scope.filterTerm = ''

  renderTimeout = null;
  $render = $('#render')
  $code = $("#codearea")

  fetchSymbols = ->
    $http.get('/symbols.json').success (response) ->
      $scope.groups = response;
      $timeout(->
        MathJax.Hub.queue.Push ["Typeset", MathJax.Hub, "manual"]
      , 1000)


  render = ->
    content_str = convertTextToMathJaxReady(escapeXss($code.val()))

    pos = $render.scrollTop()
    $render.html content_str
    MathJax.Hub.queue.Push ["Typeset", MathJax.Hub, "render"]
    $render.scrollTop pos

  delayRender = ->
    $timeout.cancel(renderTimeout) if renderTimeout
    renderTimeout = $timeout(render, 500)

  setupEditor = ->
    $code.keyup delayRender
    $code.bind "paste", delayRender
    $code.keydown (e) ->
      if e.which is 9 # tab key
        $scope.insertSymbol "  "
        e.preventDefault()

    $code[0].focus()
    render()

  $scope.init = ->
    fetchSymbols()
    setupEditor()

    # Delay sending mixpanel when search term changes
    filterTimeout = null
    $scope.$watch "filterTerm", ->
      $timeout.cancel(filterTimeout) if filterTimeout
      filterTimeout = $timeout(->
        mixpanel.track('filter', { term: $scope.filterTerm }) if $scope.filterTerm.length > 1
      , 1000)


  $scope.insertSymbol = (str) ->
    $code.insertAtCaret str
    $code[0].focus()
    delayRender()

  $scope.groupMatch = (term, group) ->
    return true if $scope.filterMatch(term, group.name)

    # Check if at least 1 member of the group matches
    group.symbols.reduce(
      (running, elm) ->
        running || $scope.filterMatch(term, "#{elm.code} #{elm.name}")
    , false
    )

  $scope.filterMatch = (term, code) ->
    code.toLowerCase().indexOf(term) != -1

  $scope.symbolClick = (str) ->
    $scope.insertSymbol(' ' + str + ' ')
    mixpanel.track "symbol_click", { code: str }

  $scope.howItWorks = ->
    $code.val $("#example").val()
    delayRender()

  $scope.clear = ->
    $code.val('')
    delayRender()

  $scope.insertInline = ->
    $code.surroundSelectedText("$ ", " $")
    delayRender()

  $scope.insertBlock = ->
    $code.surroundSelectedText("$$\n", "\n$$")
    delayRender()

  $scope.isFiltering = ->
    !!$scope.filterTerm and $scope.filterTerm.length > 0
]